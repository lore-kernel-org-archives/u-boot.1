Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BDDC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2D987B30;
	Sat, 13 Jul 2024 09:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ateA2Aey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF7887EFA; Sat, 13 Jul 2024 09:31:09 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21648789F
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b2c6291038so23404626d6.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720855866; x=1721460666; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1k7+Q0XJPm+4nTx2fCJPkpUDeRrvbFl6jKaguu03VXY=;
 b=ateA2AeypeRwYf5JO9j6J29p24376xjUIUpSLgs+V+hSO59GvIri3LquDFLyPP7QsY
 IpBwlPN+SKPslVkqijqWlWZ4TRZFtMhzWGpwAUJk2ekW5WkukEJ2aefNuIMulEFYcXcK
 z6UaD2x7Y0wpcpILmRXlneMEXRLMl0kPH3/vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720855866; x=1721460666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1k7+Q0XJPm+4nTx2fCJPkpUDeRrvbFl6jKaguu03VXY=;
 b=uk549ij4qLmvjRZAKJ7Ono2n5yvLSQ38hUFvawA3w3w8TAGVoVUw+uDS7ZDWxqhakM
 IEkmcE9U+tLQ3t+t1pf/iTpdjWvw4V3uWK2U3FIA8VYaHKKGy/i/4D9wdJ9a5JoXXLIJ
 fbZYItCbiH8crSUzB/QAHtpyTLRF7jM5a39dUG9PBImkmhyY0eC+knoXP8AtJZXdjlSu
 6rtmfuXLLBxOOHjQ5IE/9L0ZBFPipoGWUEhA7sDRY9QwNJ54cMCYodJPzPDQT0t4PjSt
 Ty2p5EYAt4EKBdtt0Pg5NN/2PlrQTneJlNxRViB1kW6lxvsyCAaVB+8le4uo3wR/K3TR
 vZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXie5qT293S8UcngZgUsD47gTu94cH+ra4tOzKcbG3tBF0DBtcRzPYcTHwnbIaJsoAxV2kI7EtGK03wmqDJjW9S3Ato0w==
X-Gm-Message-State: AOJu0Yy6MuyCylB7U/0FY3Tu0qYwSHtpBdY3O78IJM59GphuShL+3fwk
 WzqzexYwbRWe/1eEMxLvN9tfOXcSMo2FmtNu24KIHvLZqfzaxeHVnV3ub31nPMhsxMWzCvruhMF
 WGhAHBHFnN2nxGk8LHtbHhzMnfoJX1kVt3FpS
X-Google-Smtp-Source: AGHT+IHGkO1JrNK4L53CAJhsUOSzTkMtlVhbrNsLcCuc2rHGSvAUxfsh38NKyJdPUUp1ZciIQgqmaTkCiZJITNzVqLM=
X-Received: by 2002:a05:6214:2486:b0:6ad:84aa:2956 with SMTP id
 6a1803df08f44-6b754bc34c4mr95301296d6.13.1720855865747; Sat, 13 Jul 2024
 00:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMWxwJ3nfSmDOB5O2ccmyEaWig6QyCs9H8POqdyouhY0fDox-g@mail.gmail.com>
In-Reply-To: <CAMWxwJ3nfSmDOB5O2ccmyEaWig6QyCs9H8POqdyouhY0fDox-g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 08:30:55 +0100
Message-ID: <CAFLszTjLexWE5rWvQmXLqVvATqmJ6s__b6HX3aYKpyOjtxdeDQ@mail.gmail.com>
Subject: Re: [coreboot] Announcement: Official V0.9.1 Release for Universal
 Payload Sepcification
To: Lean Sheng Tan <sheng.tan@9elements.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: coreboot <coreboot@coreboot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

+U-Boot Mailing List +Tom Rini

On Fri, 12 Jul 2024 at 15:37, Lean Sheng Tan via coreboot
<coreboot@coreboot.org> wrote:
>
> Hi everyone,
> After 2 years of endless discussions and relentless effort, we officially=
 landed the V0.9 (and V0.9.1) of Universal Payload Specification (UPL) yest=
erday!!!
>
> V0.9 formally introduces using Device Trees as the standardized Payload H=
andoff Format to pass data from Platform Init (e.g. coreboot) to Payload (e=
.g. UEFI payload or LinuxBoot). This reduces the data handoff friction and =
proprietary handoff formats currently exist in each and every firmware proj=
ect (e.g. HOB, coreboot table).
>
> A brief historical background: Universal Payload started as a sub-project=
 under Intel's Universal Scalable Firmware Initiative. Since its introducti=
on, Intel has been actively seeking for the firmware community's input to h=
elp make it a reality, to help standardise a common architecture and interf=
aces between Platform Init and Payload. Later on, 9elements actively collab=
orated with Intel to work with all major firmware projects (coreboot, U-Boo=
t, edk2, Linuxboot) with the support of all architecture (x86, Arm, RISC-V)=
. We have been actively promoting and collecting feedback in every means we=
 could (mailing lists, OSFC, OCP Global Summit, COSCUP). I could not find w=
ords to summarize the 2 years tireless efforts made by all the UPL contribu=
tors: with about 2-4 meetings per month since May 2022; countless back and =
forth discussion and some compromises made in between to find common ground=
 that fits all Firmware solutions and projects; some technical setbacks wit=
h failed POCs and then persistent testings on coding sites; new expectation=
s and issues pop up now and there that setback the initial timeline again a=
nd again... I owe all of them my greatest gratitude for their hard work. I =
would like to specially thanks Vincent Zimmer from Intel for making this ha=
ppen in the first place - early commitment from ARM, Intel/ edk2 / Slimboot=
loaders maintainers, Chasel Chiu and Dong Guo, Maximilian Brune and Arther =
Heymans from coreboot, Dhaval Sharma and Aaron Durbin from Rivos, and Simon=
 Glass & Ron Minnich who are both great visionaries in the Open Firmware wo=
rld. In short, this is truly the first ever community effort that brings al=
l firmware communities to collaborate together, in the very common goal to =
make Open Source Firmware a better place for everyone.
>
> For sure, this cannot and never will please everyone, and like all things=
 there are always many issues in the first revision. Hence, I sincerely ple=
dge to all of you, to help and contribute to this spec. This is an open inv=
itation, as we follow the ethos of "For Community, By Community", the first=
 open source spec that is owned by all the open firmware communities.
>
> Please refer here for the latest spec:
> universalpayload.github.io/spec
>
> Feel free to contribute here:
> https://github.com/UniversalPayload/spec
>
> WIP coreboot patch:
> https://review.coreboot.org/c/coreboot/+/76591
>
> Last but not least, I also wanted to specially thank 9elements Cyber Secu=
rity for all the support since the very beginning that helps me to navigate=
 through all the hurdles and issues for the past 2 years.
> Let's continue to work together for a better Open Source Firmware for eve=
ryone.
>
> Thanks,
> Sheng
> _______________________________________________
> coreboot mailing list -- coreboot@coreboot.org
> To unsubscribe send an email to coreboot-leave@coreboot.org

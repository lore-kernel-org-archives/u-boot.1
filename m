Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC0EEB56E
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 20:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6258A86A6B;
	Fri,  8 Sep 2023 22:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prp.uespi.br
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=prp.uespi.br header.i=@prp.uespi.br header.b="M7TttDkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DBE86AB7; Fri,  8 Sep 2023 21:41:50 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CF686AA7
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=prp.uespi.br
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=project-tvbox@prp.uespi.br
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a64619d8fbso300158766b.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prp.uespi.br; s=uespi; t=1694202101; x=1694806901; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hcQcotTlxJIzoqSwecnR6tk+Obyn9SzYPaVXpdFYzFw=;
 b=M7TttDkKnNHyuHY82YMe2a1gbFstYfULPVWPSiNaz8AP+5WjElVNMCbLBYjgNt8mQu
 oAzwbvSjF1oj8gcAb1rrxZPfExkjcXp5kaZkY9I6Q+1PdkC9RhtrglCjOhGqXiPAutck
 9Uv4sH2an2hirRQir+KgOCnBG+XsND/hCa6YKlINgKzzxj8KUwTRvgY18dgY8iSGw+DW
 nl7SEFcH6zDv3Up301ajZHLJB/IsFHF97Tt7nW42oSAhzwd9w1z9HjmdxUxyepS1Epzt
 YZz3Z17ZdRSy59OlMGovlV7tPx4W1bIbKvLnppWW/SBFnROck+VAEsAe/89YXpox6mqe
 waBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694202101; x=1694806901;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hcQcotTlxJIzoqSwecnR6tk+Obyn9SzYPaVXpdFYzFw=;
 b=uS2n0H8UnEO3tqfUgEq0BZr1chx1HzCrpLx6Dg4GieGbe4xqhhUNicfLNe/aIuLP85
 UmSrtfk3nrtxVIEOYcqrdj4hXOTc3ZlhcagTSUYloyqrjQHnTYT5YIxcoco5IvQKQEX6
 cPiJ3i8Wl4PwxgELZT8v07/NRKBznV1NRemShPTJsbEz6/bKonKicUU3itjTFnkJoR9E
 iDZhNL0i526TeKOau76m4eG8+Plo1MIC0CSSQuz1pTfyOalDBIJouqzIR1iNplsGhzZv
 OxKV6QnYtBSRcCST2/Id91ge52470HoE0aGVRua7c26EQEHfHai9gGRXU6KLiKc+6OAA
 AZEg==
X-Gm-Message-State: AOJu0Yw8F4glWD9W6poXu9b625ZYI0g13P4LjPX3qq3PtzXz04kGLeZ3
 3+u7r8xsMDOW9xQkrSxy6uoXpGZxaZ6JtirujWSjkWLsXjYz5UFbq1eJeQ==
X-Google-Smtp-Source: AGHT+IGu5nTOuQecWJ6ZFO4UIHvFHzApozYB8YjEHWBLqBVGLEPVI/j23RwEIoP8GozLNZQpfSd6hbzwYfom3fl0W84=
X-Received: by 2002:a17:906:3044:b0:9a1:d915:637a with SMTP id
 d4-20020a170906304400b009a1d915637amr2954799ejd.61.1694202100974; Fri, 08 Sep
 2023 12:41:40 -0700 (PDT)
MIME-Version: 1.0
From: project-tvbox project-tvbox <project-tvbox@prp.uespi.br>
Date: Fri, 8 Sep 2023 16:41:30 -0300
Message-ID: <CAC15VHQNDQAedW2xd-3hhHxgmSYjom9NVUHKMqCcwEirzf4J8A@mail.gmail.com>
Subject: about ik316
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 08 Sep 2023 22:21:30 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I have hardware with an Ik316 processor that I know is similar to the
h616 and h313,
I'm trying to create a u-boot for hardware testing, only it uses an
emcp-type memory,
when I compile in mainline mode the error appears: dram settings invalid,
and when I compile using legacy mode it shows error:
[439]HELLO! BOOT0 is starting May 13 2020 14:10:04!
[444]BOOT0 commit : 593cf83
[447]set pll start
[450]periph0 has been enabled
[453]set pll end
[455]unknown PMU
[456] PMU: AXP806
[463]vaild to:8 select dram to0
[467]board init ok
[469] DRAM BOOT DRIVE INFO: V0.52
[472] the chip id is 0x5d00
475]ic cant match axp, please check...
I managed to get the dtb and tried to use them following the steps on this site
: https://github.com/hexdump0815/u-boot-misc/blob/master/readme.h616-legacy
but without success. I would like some help on how I can change these
parameters
and recompile.

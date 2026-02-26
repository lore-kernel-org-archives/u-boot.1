Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6B7FD9E24
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0F983D1A;
	Fri, 27 Feb 2026 00:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VKEQ+V9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7867E83D8A; Fri, 27 Feb 2026 00:45:39 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5146A83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65baa72399fso2199644a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149536; cv=none;
 d=google.com; s=arc-20240605;
 b=BltdwTtHZuC1bV0bLRm6LlVLp2oPJMfZgc38vlR8BBxZxK/GUJPAOYIRA+UM8utQPk
 nl0wxyQtNSKwVoHVRtk2KEMVm3SKUcE3aBQ0/sn0hQfN9RHUWwCsyhmER/NtU7Ak4vsU
 AYicfEXO7fxqcazhsFyR/ayRecIkRT+0Fb3aY5p2eUpUd1IgeutiLvV6KzddSa4tctvQ
 QGc6SMPc/2KXB7+5C+Jfdr12ABtuves6SFjk5xScOh5glUcOKHSXfeZNFEQ1iEdaQDv0
 D9vFhyXMtmQ3c+yIRvUj7E6g1OzUmvpitgAqCfJwe3dbjtISSrMixxum6IKQF619ixxj
 6sCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LWnn+frZMLA+348N7m/ZB+YIC3onkELA5ytUAz1EWTc=;
 fh=mn5V3Z3EQoSFeSjXpIxLtWYvp4nMGxThUgcID4Uu8+w=;
 b=eeC8ptxFDgA6gUj66eKgi2krwC02WtgKP6QDowPPjg+kPAfX/E7CC1/+4SlVXIB5RA
 w5ly+7q1N/uTKHe624uW5/LwJwbv9fepLxjjs/6Hgnkj2ufpsCQJo2SfXOxczoLFGRE5
 MJdne+Sp0lv849VWlnBJM55GwXCH1rpQSPP6JouefmdZegB2gN1ktxey/J60lCaC1ne0
 C3PcXxtNtvmD7xLw82F25RqI/AZUFKUALpsOiAHjl9364qZlLR+yTohYNbLB9NyPYN9i
 p/bcVtUYN2OskB8fSBmRmw5Lz8PUOSpxkJuHeDzcVomOUPalZlfC+jhDRoODOalpnsTz
 y5DQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149536; x=1772754336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LWnn+frZMLA+348N7m/ZB+YIC3onkELA5ytUAz1EWTc=;
 b=VKEQ+V9ROXbbfD64y3bHHVMLniOOBRDBaMfHMy4mFLAyIzIuHJUcMYvchkkrsmKosw
 53ZxJUS0HDjWL/wmyKh8V1WmsAOFA0L+rqy1NSG9H2GIaD+ldG6vnsa5BFdtFq6XiwNj
 LFrYfYFYCPgYLsIhQK/518A3TP/J33hFbrPSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149536; x=1772754336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWnn+frZMLA+348N7m/ZB+YIC3onkELA5ytUAz1EWTc=;
 b=eIfx6RJPkAAhgCkPTQIeqqccfkrRdRehZA36mN/E8A9m8UYtFrV9VxwWMeVxDJZ7k9
 BM0qCMXNOJc6/LY6IJOphULhDeLSHOWgnSrFIyMr/6btmOrgDzWc50t8szFq4VGHyxcb
 ToIfFlEScJcrgbA1aUl33adVA3gIyjRlCPl6YPEpJVzK9SK7ItUuAISxEteS3qXKkE+s
 8N9Fdbok4DpHZ2DqhqZOED58hFuvFGNJzbfqc3ARVffx9KaTq8JGg22FWjbp/9f17Hze
 B6OLKE73tepKhtgNpig9rSWVcc/Tw5TpLVRkh3sOlIT61mATnZo0Jt8Rcu/FpYd+35Zq
 F+gA==
X-Gm-Message-State: AOJu0Yy2h3RlLcX6FyJ+kC9jfE73mlT61lETLKjPRwWq3auOZjJte+GU
 c01ULZHitAPLB0ZSNT/vXc2NVdtXBK6Db4m7Jh0brQrHQdJ1vbnZzMpLqpKu2NP7gqTOgs9fq1O
 YwIBnqzQkaUL+mHqbE+vvUQF++w5gT+QAWgoAOfmO
X-Gm-Gg: ATEYQzzUJMdu9rQdo5PJE82WyddESiNmygR0iiZl9EeFa0nq4fMphUQT9VsaIs6qB11
 B1gGM8NcI1pTMahVVG6/ErGsbzpBzwq1TikA1iCtHVCPR7/eGX0hUfW/CvcLBYyct0FHpKoLs8I
 Ta8qKD6HHsUsn4LLh452aCBO+bh5QFDR1fjPN/Io77NxAmp6481UMV9RmyS/HID8hw9NftlWaa9
 +7I51kAPuFBiUNoh0uhqq7MB+LjRKjqw5R88lfLVFKouCM3pu/Bf3FrSY6sQcnf+k9gShWjloEb
 GHb20w==
X-Received: by 2002:a05:6402:5113:b0:65b:99b3:d517 with SMTP id
 4fb4d7f45d1cf-65fdd6efba0mr694755a12.13.1772149535815; Thu, 26 Feb 2026
 15:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-3-sjg@chromium.org>
 <911baca6-2a28-4162-995d-46e47da33efc@cherry.de>
In-Reply-To: <911baca6-2a28-4162-995d-46e47da33efc@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:58 -0700
X-Gm-Features: AaiRm52GSkB7R8jjs2_qmat7A0piODKCMX0wVffsw-Z9q3aPT2nLqituqcg5Sto
Message-ID: <CAFLszTgCK+JHYBavW6JFm6+5tpetqbuZipN2eLRhLg0YT4insg@mail.gmail.com>
Subject: Re: [PATCH 2/6] binman: test: Drop the number prefix from non-dts
 test files
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Thu, 26 Feb 2026 at 09:33, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/25/26 11:50 PM, Simon Glass wrote:
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > The non-dts files should not be numbered. Remove the 340_ prefix from
>
> Why not? Now it's more difficult for me to know which files are supposed
> to be used with which dts/test.

Becuase the numbering is sequential and if two files have the number
it is confusing.

>
> What do we do once we have a name collision? Start another numbering scheme?

There are very few non-dts files, so just renaming it should be good enough.

>
> Honestly, I'm wondering if we shouldn't improve ftest to better split
> tests. Or maybe split ftest.py into multiple files.

Yes it is quite long. We could create a shared class for the common
functionality and then put groups of tests in separate files.

> I very much dislike
> how we handle input files also. They are set at the class level and any
> test can modify them. I *guess* it could be fine to have a shared input
> directory among all tests, but it must be read-only so we don't have
> side effects (we can then have a per-test rw input directory if necessary).

Having the input dir be read-only seems good to me. Yes we have a
per-test rw (output) directory (from memory, have not checked).

>
> I guess we could have a subdir per new ftest split which contains all
> files that pertain to this test. We can group them by theme for example
> to not have to have a subdir per test and overwhelm the user (though
> that makes it very explicit what's to be used with what).

Yes

>
> The change seems fine so I won't fight against merging it but I don't
> see a clear benefit for it so I'll refrain from giving this a reviewer tag.

OK

Regards,
Simon

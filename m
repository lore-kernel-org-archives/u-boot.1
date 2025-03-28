Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A58C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6D781DF6;
	Fri, 28 Mar 2025 14:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFFc0mVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E2881E1C; Fri, 28 Mar 2025 14:24:09 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF3781DCC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-54b0d638e86so417324e87.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743168246; x=1743773046; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ae9itmRdH7RFl1rCEPsG8Mkk9xYXXbiayQ0AIAczchc=;
 b=IFFc0mVhzMLgOLvRVqG+25F76mOX2KY/ahr0oqELMkCbdBW8lDjN8jI0c+VP5N7blp
 1gpGy2rDRtq7Mq+rzLrEZ0dO5iAQur1/+w8FDjAvAxxMBFNS1d6evvzSByETprJjPg6X
 Jm9+nMNFzfj/r1+qJb3iAfMDAtdIjYniv4Dw4GPp/JpzFKgtZ5lXI4aAznOSxfNAybVv
 LTnGPJ1tpqR+cb9eYv8U2fsYBT4dw5Y5L0lfFOSBOEPwtHdMLwx08DnFW93RDqaDCPGy
 MEHWoWv+kBoGkCxcIR8PJ6MQhNtJMm8syyyIWqUe1OgWRPYJhSkqCSuS057gK0+ELWbS
 x4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743168246; x=1743773046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ae9itmRdH7RFl1rCEPsG8Mkk9xYXXbiayQ0AIAczchc=;
 b=K8msxg30dEZhVvdD7qsrJA+uGQ/G9clCMz7YsNysOIPW/XKR7spqZSc36qjyCZ9vd6
 J0+u107Lbuhuz/pKkSaCAhfn07YvDmV41R02B3mlcXYxEHyHSSUSJiE9dsZNT8rq9NBc
 J+zKFCIPaEOi4mJ+xJUqwhvU8cx35BO6UKAStQakhgoD2MsNJzwDtHTYVA04vfo7GLFX
 pP1Y396jqH/KAHqi+pygnIObm4PsMyMNP5iyTn979vAKJp/zufEwzXjifV6aihIX2wjX
 oQezKxiBQ6dnndLFwPGkLWM610s6whYVCAYJ7cHzLd0rSxH8MRNLfVLsrSXxMKGmG3N6
 9tgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWlHE+YCitYHXpynca/vlwRpmU1sAwe5ZZKf7BYiUXvWMmPGAceeFtw+uugD0RtTb27CKo7hI=@lists.denx.de
X-Gm-Message-State: AOJu0YwujoTEOJ/XeMvYl/yBxqbpkC65KJqCPe1VimB3cREzhwIb0v1A
 HRMZHE5bJECpxuMW8p7GlvCqMlQcpFnxrdyDKOwhQX4h5P0HrYVp/kWDszpv6RVFGVuOMO+LJQ/
 aqtU3b3lB4oz0Sjwv8IqjfLGRRt8=
X-Gm-Gg: ASbGncsXP9zK2MgVt5cBrJDkD4wpqZwCvKBNV8uJb/c39JGCOzdM5U+yXpcJZ6HbNLy
 rFg/kV10ORbyy+cs7iMdYQ6ifexP/gafEvxmtP/MGpSTSxEplEvUdO+LnUNPyRNE4rdFSKsHSpS
 ShWAYCf9C/Ba8vDWKBJnCRrWQotksYXekN2I6d3vixDP7mAB9Vk50Fg5abwRjcW9+XTxXU
X-Google-Smtp-Source: AGHT+IEjL17NBVJO16tFJvu82tu9lsbV0RkAfleXpx85SJpk5ElHejGNa0cWlB6j7TJ8J0AJ4shfQal3VcvoWARuJYI=
X-Received: by 2002:a05:6512:4010:b0:545:ea9:1a24 with SMTP id
 2adb3069b0e04-54b011d6331mr2775833e87.14.1743168245926; Fri, 28 Mar 2025
 06:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
In-Reply-To: <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Mar 2025 10:23:54 -0300
X-Gm-Features: AQ5f1JoRgS99xZZqpccC89wDB7dKTTvBBkD8nExrSKQYdNNeU_zuID-Vfwm5BEA
Message-ID: <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Simon,

On Fri, Mar 28, 2025 at 8:42=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> Did you figure it out?
>
> I'm not really sure. It works fine in my tree and I just tested it
> now. Perhaps there are some other patches missing from Tom's tree?

Applying this patch causes the following CI error:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1079236

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Ru=
nning binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
142........................................................................=
...........................................................................=
...........................................................................=
...........................................Image
'image' has missing bintools and is non-functional: cst
143Some images are invalid
144......................................Image 'image' has missing
bintools and is non-functional: cst
145Some images are invalid
146.........................................E..............................=
...........................................................................=
...........................................................................=
............s...........................................
147=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
148ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
(subunit.RemotedTestCase)
149binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
150----------------------------------------------------------------------
151testtools.testresult.real._StringException: struct.error: unpack
requires a buffer of 4 bytes
152=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
153SKIP: binman.cbfs_util_test.TestCbfs.test_cbfstool_failure
(subunit.RemotedTestCase)
154binman.cbfs_util_test.TestCbfs.test_cbfstool_failure
155----------------------------------------------------------------------
156No cbfstool available
157----------------------------------------------------------------------
158Ran 581 tests in 5.012s
159FAILED (errors=3D1, skipped=3D1)

What needs to be done to fix this error?

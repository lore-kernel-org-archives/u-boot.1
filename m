Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EBfPlUi1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkoJlAwl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6309F40713;
	Wed, 28 Oct 2026 13:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsn5Um-m1HWJ; Wed, 28 Oct 2026 13:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DA5F4061B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194598;
	b=TjFdxliNVdZdWxV7sLfJ7AIrPHOrigvJIP8O46sQwMSWRdeRVqox77guD9ihJAzm7aDk
	 w/8H0O4nVxQhgErdN71ske8z7c1zHVHeSt64RhkU9SFw/eT+aaqFLW3fCKNgH8jWeQySp
	 wUbIZ5HbaWpHxmpOMGmtDzAxEXnh+AQkuDjZSAgVVi6Y31o0oogVzl5c/Jot9DzhZWjrc
	 C6gw0DhFbA0O3fZ4XmjuZSAMxaCQcFlF47w1TzgAx/cNYeUHtFlj/w2KSgFshANVUIe4C
	 gSKozo2AXxI/tV2ZBS3Oc0kH05C8KShcRjTsGlLrGjSDGK+hOcZxNSZUtdkk44KenPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
	b=o3T9yDn1lmlJnY3igmoBTPh5geZb3l4lUyLs3iWeqh11QWoa73wLU3nICWpzY4GrCgNJ
	 yAG+BFeX1SI7kzZKpLQSyO86izQNdfxWuyo//GzqU6esmkfAM5cZ9bDT691tfA6CxmLds
	 9fyhsAwidaEPRj6uaoUCMM/idiCCgY3QiwQlU23yR+4t3JufMoOC1UT1KJ78byNRhqKRY
	 C3Jkq6Z6rM2up0fzLuOS4XahLSOwtjHfnRiuIm+0XqDyJgVhOPXsHcQpmVYle+me09OYB
	 kTGfUnhhTKdghN3vyS3zkjnhBPecQiV3OftqQPoDCJH8Ee+810BB9Y6iDiSZwP5tM/Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194598;
	bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBfPlUi19rFYsGm3AuzvyTu1sQGJPBdQwvdUUQmQVZgcfCQ3H2ru7pnun6Bg6cw38
	 Gzrzk1mikOvV7IJn/tgqpJmhXkB+RONdzj/QOvAi6CMeYH03Xhd/K7nmknEjdx8u/P
	 XOJHWmOAUw5kitKf2bA6P6siazqlAYa8wxYxVCjMkd+J8bqqU28YPSUllhrIE5zsfV
	 KI80kIfGExqRfPlnNDUei6UgA+iG9H9CK9DBDO2EM8WlM+81LUzVNYHlNNhMY54kBy
	 2zy1zoFY6WrQIXZXzxT9Sj3ATYipX9osD7ir7G136QLEn73hYRq3I27SyEZHZEUfiH
	 DA7pksSoy57+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DA5F4061B;
	Wed, 28 Oct 2026 13:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A033972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BB8740087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21mxSa-DxyVu for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2C4B54006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793188397;
 b=q++QkNrbBFtRTywzogCGn/W57HrcGVL0Z2oM14qxnD3FOci2W6Ac91NDWlfes6kEyO4q
 HDxgnV/OWR7krVi+yisO6j0bbmy/fqaWMFWuF/5FMwzC6iGP/XVNPa4IYSF3d9nkMYYAC
 xOebskavcVuYToaiH4PDt1y/jUI8z2U2lzVt/0J0n0xXWCexlI74Z7Sdkl2qmKCWiUPGY
 0RY07v4H40a4LRHEEYLklbMn7/RAaQiT41rB32e6j1VqjAv5FXCVWdYkmmpbjZwIYm1bK
 SdxXQ9xjiUDYy9oQ6/K1fw5pQDkDk4ilQ8Na9sX96DhBQ/72CxPZYEcOIHW+Vv/TsZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793188397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
 b=jji6H6umpWJI5M3aMyq26HrGBfRX6jraI3hMCRhQyykJM+pu5nGaoaJuTXAg2HQS/bAn
 Aun9aDeOqb59Hj75Q+5bsySrffhfZ4bJ0QDA1OH7NDuCZnd3JXpZcSdrKVDBfb7iEzITD
 AXAHrnIUbc1Ad1fes8W/d8VcKNSHBiKOgoToYE4/6YvE+u4aVsdMpAytHYpmrnhAf3k8a
 FTKbg+Or39tSmIgxWNVB1s+zze8HJL4pAdUyzyKbfGSKca+QX5vS2kaAUP6WFBMEKSizd
 JcEedxpqLHOoxNyJ73S5FcyjpnrZyZrs6kGFB6ZqVu9ReYOUqqRYrlyrfxBMzLApa0Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FkoJlAwl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=odeschamps.mail@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=FkoJlAwl
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C4B54006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:53:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so1427711a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188394; cv=none;
 d=google.com; s=arc-20260327;
 b=rke72+23kNyNzWb7yPcTvDo92QPHS+J4n52wOcPLl0WM83DmzttyAeIEK5Gk+++U4Z
 3kVWEOsyH5wYA+XHjwa9QgrMkDMV2rQPxWxZKBxesM550Z5o7SzhlINdeiDaNCqED/Xt
 qa49hhT0JCFcy/rt6VIN7RdIvFC7Sb16tPGM+OaSBgmB+aY68t0S4b4+sO8rgbQl/eq/
 0W0+5eu2xcDkiR467kYa3tzy73bm+T3TaagACSBkbDYr0OXkuIKeU25sGPv0EcEL+fjI
 eVM/dsOnQMirrlnh8genLpAX05D9hA7gIVxlUs25+9GN14AWuxN3wkAgvvEFoctG+Rec
 hB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
 fh=7D1B6n6JkQf2romy4tAYYgQG9xMhMfDFKwqE4p4Znas=;
 b=F55UoXIgjbg6oeS5KVLoaKPdiG1X/Okw62QcWmwS2LbiWEJlQ8nuiBwe+dkBBYfxRt
 Dz2NgjMUjvY8+0AWxcVGJgzzWeKnjd7hKlSeqY/FB2c4PzIOi2+zmeKbFamHVcHAvYKW
 4gKZ/A7Y3oHmI2DBJxD918QGfEbZ7bpJFqVafKd/CIm0Vq0uJ4v6athl0l+V7LYJm/1G
 r0vM31/tHBlXyqr1+ZTuZzSrzzPV0mQUTmsOEwos8jLSUyiHY3xRuIpVK74mpmQnw+wo
 xCpE7rwWmE8gMS3fgD/iqoOeEBAr177jHVycENobJn0/4+H1XMJEzyFBVDC9LUxEiVac
 5qBQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793188394; x=1793793194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
 b=FkoJlAwleKnwQlK9h3Tbg3XOO7nZtOTdFPyDbn4Okki7+hNnMrEHl3Y0FJsM0ZleM/
 PBkS0q9jY8TLkDK7HZwBLFjz33lXPc+uiULq2suFc06n87PPm5vQbuSUgdRN71Md4xxL
 zIN1cqv4iHd782FEvuxgjxlCWe6t32fV/BUeLKiKRfjSDupFLoHbNsa/Ip/4txLyBpWg
 tJ4bSQPb5xGzSVPaVMvQPCTGhk0quaj3cheNzbjcW7q0h4llFKXWVc0U4dmyCjaqMbhE
 beDPtulIIa44ngu4kVVLm+BV+nExqqqy9z7Vg7adrkyyoao0S88fzqweonv8Y/Vfudj8
 14RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188394; x=1793793194;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsMQZX1ocuqoW4FkmwEjZ96tCgMXtWhmd764f+KGUkI=;
 b=gnj1icW7gTIj80ON3HLcM5vL3zSXsrC+O2NAAvL5eHPdGsaTZQeTK2uSmx4qVZj6bn
 d9nD6DqO1uEJMsrB+GdGoy2gfJJgX6F/DPkYKXEmemLPwnqdmEKq/ssHk+m4bCGVscfv
 eFfLSAF5UO6XS+7U3mzm0GkeLib7/80HNQP5OIgpcqUILKN6Fz9ZcjcaYRIO9dBoSXGG
 m2m2M/h4VLqWua0OT/euKh5dfukLSe4PKZp/FV8UoTaH7eZbnnCXdVJC7oEom1WAbSoR
 aE/NQU7cJTWIjyNy9sD/az/A2j3hGfpkfA4V2tKk6GKC5Sr4IZMYRoUfyCU97RfMDHeS
 fXBw==
X-Gm-Message-State: AFq9FYKLSl6MK2MFumjhP9et0n/QNm6nxS8BPdgJA2YH6C6S82cVPIgS
 EW3TcOcgABeNB3DlJAdYyHdv0HlFFu/ososhHEaO/ISgR9sUiAbTFOiE4Q4og21D56B37WcKqQ0
 IDLC/g7hAOlm1VlKS2Cr+RFAcjsdsfQvZMOv9r7uzKY5V
X-Gm-Gg: AYBFou3H15BvcfJHdAvnxGsAKoBMbJEblNQFCutyInaUOvtCMWvVKIqp6fJW8Nroy52
 M3ItQCNrhvCqeURPD39uWCsXsQ1x2nN5fsvK8eleS4ZAnvVMT0mMGkGtld8I+jEmuVjfWj/qbgz
 AwAV2R58hhTo1fBBT0BLZuGGyLgjrtcnO1zX5ihKYx4ye78dhsVU0lOQuaAa5cFB9GutyGGNh2c
 G8oweipkDdlF1GoQu2M/hbK3ca2bBN8uwQ+1fydd09CG8X1ekLAxR111FUvg5rQjmRmlTfhNlQQ
 HpbAwOTdjxKht/5o0iehbqUH4cnsMvd0ABHgKeVncz7JE4mlSHFlUDkyEC7nYjUtm/t/Cm0Atbn
 mEd5d9pUszwpJLHF667H4AgPHeBbW6IL6hiC3DfBx1P111xat4x70v4HwzPilmTOgdz5ai2pIWp
 A=
X-Received: by 2002:a05:6402:a514:10b0:6b4:98fc:531c with SMTP id
 4fb4d7f45d1cf-6b49cbd667dmr887281a12.9.1793188394345; Wed, 28 Oct 2026
 04:53:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027131837.177854-1-odeschamps.mail@gmail.com>
 <CAFLszTjw=Z9oX=bdBNqK5YR_8VZy1ObF6ivgjZfni918nT4kOg@mail.gmail.com>
In-Reply-To: <CAFLszTjw=Z9oX=bdBNqK5YR_8VZy1ObF6ivgjZfni918nT4kOg@mail.gmail.com>
From: Oscar Deschamps <odeschamps.mail@gmail.com>
Date: Wed, 28 Oct 2026 12:53:02 +0100
X-Gm-Features: AclHuK_8EwXhIAbj3dHw8LnWmMmTANkwOrBJTd62acbO6VseKvDyAJVkVzw5lgw
Message-ID: <CACz3q_6EWy47DuHwAnVKevpsHaR3vEwT7_g0TK7+41Wppv_V_A@mail.gmail.com>
Subject: Re: [PATCH] lib: date: reject out-of-range month in rtc_calc_weekday()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 vincent.stehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review.

I should have searched the list before sending: Vincent
Stehl=C3=A9 posted the same fix on 2026-10-14, "lib/date: prevent
out-of-bound read in rtc_calc_weekday()" (Message-ID
20261014-wday-v1-1-d6a45cdf7c5f@arm.com), already Reviewed-by
Hung-Chun Tseng, with the identical bound check. I don't want to
duplicate it, please take his and disregard mine. If the month-0 /
EFI_LOADER wording here is useful it's welcome in his commit message,
but I won't resend a competing version.

wed. 28 oct. 2026 at 08:35, Simon Glass <sjg@chromium.org> wrote :

> There is no test/fuzz/fat.c in the tree - are you planning to send the
> harness too? A small unit test for rtc_calc_weekday() with months 0
> and 13 would be good, perhaps as a follow-up.

On the harness you asked about: there is no test/fuzz/fat.c in tree
yet. It's a libFuzzer harness I run from the sandbox FUZZ framework
against the generic fs layer (it's grown to cover EROFS and SquashFS
too). It needs cleanup before it's fit to post, but I'll be glad to
share it.

For the unit test you suggested, I have one for rtc_calc_weekday
covering months 0, 13 and 15 (rejected) plus valid months; it fails
without the bound check and passes with it. I'll send it as a follow-up
once the fix is in.

Thanks,
Oscar.

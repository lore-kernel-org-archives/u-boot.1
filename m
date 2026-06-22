Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3DCDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 22:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDE284944;
	Tue, 23 Jun 2026 00:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nnp9uw0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035F5849BB; Tue, 23 Jun 2026 00:43:52 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 441AF84931
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so4043632a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782168227; x=1782773027; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMmJgJjVLEz7gGmH0awpe+ahMsFCG9LfRuYCgYPJXo0=;
 b=Nnp9uw0PB/+jAu4ck1Yjf+JEAkxBkKnX4Cmp9OY+xESu8zYM+ROXhFDkrNqubYh3xU
 cgrGMp2PcJgPeKDx6gxJR9g6tGvHO8IAf4pNH1cBK2Ma8VV2Ocjm2f9JRkvRnS2zs1AQ
 iHkEOF3iW2J6nvaTBbZOmaXEvtWFN+M1pFPpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782168227; x=1782773027;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMmJgJjVLEz7gGmH0awpe+ahMsFCG9LfRuYCgYPJXo0=;
 b=QzRPEbg9/BpYpTVPLJ5syevix7mqi/m+XGCmbQ6IwI/7WBpKoE8Zkn3Rby51Jj9Kkm
 yC8R78MTnDqtxr3JNu5imeaCsY/Tr71NPvMSv0vS7rk8fT6I6wfh6BmHZICpb1TrY3Av
 AM+H+fT5J1fJCFGtbckIB0R97Z2wi+pxi8LvDc43Pb/1TXsqQBWxrqUeNDxNAvdzoB4l
 13+GLHKKINNiNCh/YEclCBT34tNWmaxObZKi595/kN7patObMCjEVBE5bU8+v4AM3y+q
 l2yXmWQXJOWhCsF+CIT+B5mSLnT4CyAsfKsmIAFQ+83+BL3U63EFGL9VN0cT0R1r8VDj
 O+nA==
X-Gm-Message-State: AOJu0YxljSqUdXxAzc/XBtnMREAaz+VhxACFhyoXJaY+wP3nkOv53Wkj
 +RCgfadOeH9+kOpxFIex5erKNsr7cvPpwUWdKHQa7zZCIKq31wqJVqm+fEgsvNfRyKImKijypNN
 AqrS8l4M=
X-Gm-Gg: AfdE7clwzJKtnIH2jzphEJRY9OaacAAjutPdy1Yy1n7r+F69FseX3Cc+/IIsJr2dn4x
 4MPWx7tqccNLWuH9Qn6R9DFHtxeyn8umd42ux2Nw3JhPen16g7y2JKe9DfJlw3nmfpHFXx1ySY0
 ByAHzzs4T6QamRGvglbaTlnZdQgaH7uihz+Zzl/H++/rj2KC/z/FTnFyUqondEJxknxPH8sPhAG
 /RR5O4qGveVqlN4B7VcwAwuhFBZ09HbbLxOd1dCnfI9hiWUHiq7SweYY6TIFMsB84Sp04pA7TtW
 Ij9DxMh2zemDnJugQ3httaZsd46HB1fY2t3VLDl5mDlDz+tMHF3chU+ZESpaFrCDZoxNkfApZGx
 YQILY+bexY2JhMcVXOY90kChDsgotIFJULUgKvGIjO2vTcsD+CUh2Zl7nyjzAnjoRnhbrvooVO0
 RxPcmRtX8PbqkkOPwOhQz4ujVRkIhAkpHC8+o2S6Z5x0g2RxW9HZ6/lgnmHII8+3Alg017SymNj
 ougNE1w9VdJmPEiqjFn/OecSvkdV8CkcFA=
X-Received: by 2002:a05:6830:6c0f:b0:7d7:d524:bc88 with SMTP id
 46e09a7af769-7e9793bc01emr159996a34.10.1782168226914; 
 Mon, 22 Jun 2026 15:43:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-245.totalplay.net.
 [187.191.8.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9442e98e9sm7384635a34.25.2026.06.22.15.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:43:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:44 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260622224344.GF382693@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="faJYaX37rZNSE1jB"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--faJYaX37rZNSE1jB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Coverity is back up finally and so here's the result of changes for the
last three RCs.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jun 22, 2026 at 4:40=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 1
   - 4 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 1 of 1 defect(s)

Defect Details

** CID 646439:       Integer handling issues  (INTEGER_OVERFLOW)
/test/cmd/part.c: 53           in setup_gpt_partitions()


___________________________________________________________________________=
__________________
*** CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
/test/cmd/part.c: 53             in setup_gpt_partitions()
47     	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
48
49     	ret =3D blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
50     	if (ret =3D=3D -ENODEV)
51     		return -EAGAIN;
52
>>>     CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -22, overfl=
ows the type of "_val2", which is type "unsigned int".
53     	ut_asserteq(mmc_dev_num, ret);
54
55     	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
56     		for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++)
57     			gen_rand_uuid_str(gpt_parts[i].uuid,
58     					  UUID_STR_FORMAT_STD);



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--faJYaX37rZNSE1jB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajm6nAAKCRAr4qD1Cr/k
CuW/AP9hlSFUkMAEJUEtsrnOkDHVejlaYKoayHFt6PzLeUw11gD/Tg118TA/lmn4
TWAT74pkYkvtbhzle3aFqQyt1wZwHAk=
=/JV+
-----END PGP SIGNATURE-----

--faJYaX37rZNSE1jB--

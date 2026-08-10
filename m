Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CABBC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 23:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B719580F27;
	Mon, 10 Aug 2026 23:14:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpdD5Kn7TOBb; Mon, 10 Aug 2026 23:14:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B353580F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786403694;
	bh=fOfQD6ZPPo4X8hL6NYaEpvIKkgryfEicKfSARyUMR0s=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lSiJt9yINpMkAEwRLLAdy1XfHUx3kKJ2+9UtzoGYi8HO0yF3YTnxEPAprN2/IqYKe
	 kF0UknED7z4QkaJh9TwLoaQZb+/S21mAPbWxybj2iHs+sPMEhSV3fUbualjlZOk7Kh
	 84MdMk17Mum88WLV5b8rL2NpDB3mlkJckCf9GVAbW/W0HolwTlWihIuNyIixnUREa4
	 m3JX6jaoRnL4XLkcfUV8gvfsLvKtSuQp3Jw6QPADytd9VWmO+LeVxzffcLS8C0M/mh
	 i9XvlMftyY4yRiQ5Y6iS9Iu0RG3LBhR/ndLo96EZYg4oFYT2fNudgKzgYGRTiyYPXo
	 QQTDYoneusGIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B353580F1C;
	Mon, 10 Aug 2026 23:14:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F79F218
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25F6A4007A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WyfhGk6ylEc for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 23:14:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0462B40061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0462B40061
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0462B40061
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:14:51 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f39cfb65cbso531051a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786403691; x=1787008491;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fOfQD6ZPPo4X8hL6NYaEpvIKkgryfEicKfSARyUMR0s=;
 b=XgBXG/uHq8kozBFa4l31s4T+c7Eb54HJ1UBjtppVjSJP5X4MS7HY8L/Rj+bOPJHNDm
 CM60bhqnR3+EFYLljXxr1qM7+BYGVOdkRNLDl1IaHyTQb/qTmYs+7iNR4CSQX6U4vrry
 iQp43romh827I51Uc6ThSt6uvDMa5oH3iCX7MPUXd8K32FKQiHj2b9UsU1UJxoe+ZSJu
 n5mrkgiBaUz201vqkAtQBQ26/bbRRqbsuz3Nu0HKjpsXFX18NBGNSVZCLr0YbL789Pwg
 YYzxTKWUK/7hs/jwdNtQ1S3a2X/yMdmZaBSwaMEpziWEjrb95LuxyIv0hExeK4aILI9J
 ORIw==
X-Gm-Message-State: AOJu0YxWGodQT5R7Zv0AyKnNKdUVIuQubk9CnD7/N05PS53wK8jCGr5P
 5gsBSrPuNy2oe8ihSZTSkt8J7JVONy7BLrfr8TLtRv3FkWMZtBCLRlCzDIG9r0iQu+JdbJXN4NS
 HuiLKPaY=
X-Gm-Gg: AR+sD1040Iz6cXXLHLJXXLty0NcTXL5qpNkIwMEfqEk9GQiojMeulCiUiNmO7/ncHhq
 nQvVMBmji761qI9lnug9lFaI8GqOXUoNKZMLqOdt4jyAFuNu6yy6+oCds4cTTh66ek9nxtLAJUw
 /go9XhiVNoioeM76DqIj2/YsFWLUSWiyMdioWN+UghK+63DAWp9bO03foLoPQN1hB5P4WpJsAPk
 6dHY9S9I/8s0VBAlVWO2+yjRs1vuZ8WqNuOBO/Fvm/b7PQqVp1ymmI7seUOIntyv/52lIe8WwyG
 iSyLAbK8HAsfMgacf2DxtDqVRQ9ywCRq9PbDPC5IoaTJ3yZFAlRqd3t8blaEYOUpOTeOaezie6e
 /Fd5lUU0sK+j+2Zu2E+T/89atL+m030EGNxgy93ayKmtK6DWB2zpJZ+CwqKB+AIRiSl2EZ2bENQ
 SbG0dS7i4vbk6tFz7Rr6E4Maabz7SN6ekURBEh/f09brFDPRf7/DcL5VP61xE8uV1Np6QgwKTaZ
 E6t4VTjm19Q6XEp7KOsgZdFoPD1n+4NnVLqC5WyLFmWEgOIJxPk6E76AHLmXnifb5y7XXPTgK3Z
 aWNsBuBjzw==
X-Received: by 2002:a05:6820:178a:b0:6a1:1269:c776 with SMTP id
 006d021491bc7-6b0909b11a5mr2775153eaf.25.1786403690888; 
 Mon, 10 Aug 2026 16:14:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc2631esm10844811eaf.4.2026.08.10.16.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 16:14:50 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:14:48 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jordi Trepat Mur <yordy1902@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260810231448.GH1160436@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="23T83t/wl0vA5HLc"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786403691; x=1787008491;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fOfQD6ZPPo4X8hL6NYaEpvIKkgryfEicKfSARyUMR0s=;
 b=cwRmZ2XKV7icq5glB3czGm5CiJd4Au1f2HuMuE9827BTv0YRjTl/+rTqXFBS/bVwtb
 LnD7mhv1nM5fbTt2uCtvgZRymdiqMM2HvyuFzAVNoHIII4scfJ4M8eDYFQFf5AOKw5AA
 tUiHOunj8DaLZtlbEuqOWwhxdHkc66qJprfH4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cwRmZ2XK
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--23T83t/wl0vA5HLc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Aug 10, 2026 at 5:06=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 5
   - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 5 of 5 defect(s)

Defect Details

** CID 652911:       Resource leaks  (RESOURCE_LEAK)
/drivers/pinctrl/pinctrl-single.c: 579           in single_add_gpio_func()


___________________________________________________________________________=
__________________
*** CID 652911:         Resource leaks  (RESOURCE_LEAK)
/drivers/pinctrl/pinctrl-single.c: 579             in single_add_gpio_func()
573     			break;
574
575     		list_add_tail(&range->node, &priv->gpiofuncs);
576     		range++;
577     	}
578
>>>     CID 652911:         Resource leaks  (RESOURCE_LEAK)
>>>     Variable "range" going out of scope leaks the storage it points to.
579     	return 0;
580     }
581
582     static int single_probe(struct udevice *dev)
583     {
584     	struct single_pdata *pdata =3D dev_get_plat(dev);

** CID 652910:       Memory - illegal accesses  (UNINIT)


___________________________________________________________________________=
__________________
*** CID 652910:         Memory - illegal accesses  (UNINIT)
/lib/libavb/avb_cmdline.c: 342             in avb_append_options()
336             break;
337           case AVB_HASHTREE_ERROR_MODE_PANIC:
338             verity_mode =3D "panicking";
339             dm_verity_mode =3D "panic_on_corruption";
340             break;
341         }
>>>     CID 652910:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "dm_verity_mode" when calling "avb_replac=
e".
342         new_ret =3D avb_replace(
343             slot_data->cmdline, "$(ANDROID_VERITY_MODE)", dm_verity_mod=
e);
344         avb_free(slot_data->cmdline);
345         slot_data->cmdline =3D new_ret;
346         if (slot_data->cmdline =3D=3D NULL) {
347           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;

** CID 652909:       Control flow issues  (DEADCODE)
/boot/bootretry.c: 32           in bootretry_parse()


___________________________________________________________________________=
__________________
*** CID 652909:         Control flow issues  (DEADCODE)
/boot/bootretry.c: 32             in bootretry_parse()
26     	if (s !=3D NULL)
27     		retry_time =3D (int)simple_strtol(s, NULL, 10);
28     	else
29     		retry_time =3D CONFIG_BOOT_RETRY_TIME;
30
31     	if (retry_time >=3D 0 && retry_time < CONFIG_BOOT_RETRY_MIN)
>>>     CID 652909:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "retry_time =3D 0;".
32     		retry_time =3D CONFIG_BOOT_RETRY_MIN;
33     }
34
35     void bootretry_init_cmd_timeout(void)
36     {
37     	bootretry_parse(env_get("bootretry"));

** CID 652908:       Error handling issues  (NEGATIVE_RETURNS)
/test/dm/hash.c: 35           in hash_test_success()


___________________________________________________________________________=
__________________
*** CID 652908:         Error handling issues  (NEGATIVE_RETURNS)
/test/dm/hash.c: 35             in hash_test_success()
29
30     static int hash_test_success(struct udevice *dev, enum HASH_ALGO alg=
o,
31     			     const void *ibuf, const uint32_t ilen,
32     			     void *obuf, uint32_t chunk_sz)
33     {
34     	success_calls++;
>>>     CID 652908:         Error handling issues  (NEGATIVE_RETURNS)
>>>     "hash_algo_digest_size(algo)" is passed to a parameter that cannot =
be negative. [Note: The source code implementation of the function has been=
 overridden by a builtin model.]
35     	memset(obuf, 0x5a, hash_algo_digest_size(algo));
36
37     	return 0;
38     }
39
40     static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO =
algo,

** CID 652907:       Memory - corruptions  (OVERRUN)
/test/dm/hash.c: 35           in hash_test_success()


___________________________________________________________________________=
__________________
*** CID 652907:         Memory - corruptions  (OVERRUN)
/test/dm/hash.c: 35             in hash_test_success()
29
30     static int hash_test_success(struct udevice *dev, enum HASH_ALGO alg=
o,
31     			     const void *ibuf, const uint32_t ilen,
32     			     void *obuf, uint32_t chunk_sz)
33     {
34     	success_calls++;
>>>     CID 652907:         Memory - corruptions  (OVERRUN)
>>>     Calling "memset" with "obuf" and "hash_algo_digest_size(algo)" is s=
uspicious because of the very large index, 18446744073709551594. The index =
may be due to a negative parameter being interpreted as unsigned. [Note: Th=
e source code implementation of the function has been overridden by a built=
in model.]
35     	memset(obuf, 0x5a, hash_algo_digest_size(algo));
36
37     	return 0;
38     }
39
40     static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO =
algo,



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--23T83t/wl0vA5HLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanpbZAAKCRAr4qD1Cr/k
CrgqAP9i+pjp0p01VOYupkRnl0WgeS8GUnPGxBrcrrUIIu8D/wD/f3mOKayM0GZa
LiD7dpr7DKPc0AnLshdKJaBIDGIOago=
=J66Y
-----END PGP SIGNATURE-----

--23T83t/wl0vA5HLc--

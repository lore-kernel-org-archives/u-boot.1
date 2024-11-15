Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8FCD6DDFA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED1589251;
	Fri, 15 Nov 2024 14:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRiHS4gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41BC89266; Fri, 15 Nov 2024 14:27:47 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C48D189247
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so11946771cf.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731677264; x=1732282064; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzNxkf7tWOL3yTU2+ulU1kRI0H7VoPM7i3UQVNhsVOg=;
 b=iRiHS4gBo6R9is8hlKCaW1zpqzridYxrzNbKidmr64uCYzokAz5P4wHuv3vshvJ1zB
 ddN9PBX9lRtQDPZe7Y0+EAmZzudlDMqXyip1GvGHe+LgSYS8ym66F44vb73C4vNFiHUD
 HBylfnr2xK5+PJ4y25usD6JR3qTYkqGnEDot4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731677264; x=1732282064;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzNxkf7tWOL3yTU2+ulU1kRI0H7VoPM7i3UQVNhsVOg=;
 b=qgc+QmomOYNBvpcmkaMoWzp8wMf4q+M82DoS42Oj/UNl6GYd7fe4ybOCe0ZfQqmjsZ
 z5qWyPXhElV7Ghv9+hOCf+f3RLtQ0EHsH7V5EKbZuYPZ5oMrJyn7C8CNhudwa3J2a8Dw
 NvxKH337xYuD4EtP5MGnUS6DF8UOf/zKp+21nZs8mp4R09OaIwbscJjiyupTUhkXYWPZ
 Qbb6Fwe24erwi1ZDc3mZDEnlWzCP1Bb0INRtp1jws+2/B+o38ZSUkCooLGDgvupKkjoL
 qnxvwhFu6nracWH1ENT7mpkqtYv+r3Xk/ZkWzos7gj7giJcjsqhYSNypZnASVbTHFApq
 0q8g==
X-Gm-Message-State: AOJu0YwTnk0LX/JAs0eGNVxa3kr9ardcGRTfkngzki/nXZwoiPK8dOVz
 flfp4YiF3ombR786/7tfiR9MtBD/DYvRUfWWExJ1TmN1U1sFG4vyWgLpU2pjU2bgI+fSiUUEMxq
 fvV4=
X-Google-Smtp-Source: AGHT+IEjObGclrGPNu7I7jQwm/brEqzDeFq4oq4hGklm0yrFMMbmAckaQg2FqKp0+b9aA0yvCgqTQQ==
X-Received: by 2002:a05:622a:2286:b0:463:1677:c0b with SMTP id
 d75a77b69052e-46363e3112emr34123001cf.31.1731677260662; 
 Fri, 15 Nov 2024 05:27:40 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635aa157c1sm18949901cf.44.2024.11.15.05.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:27:39 -0800 (PST)
Date: Fri, 15 Nov 2024 07:27:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241115132735.GP3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WzOLNTOP4l0PWiK+"
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


--WzOLNTOP4l0PWiK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Thu, Nov 14, 2024, 10:40 PM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 514958:  Error handling issues  (CHECKED_RETURN)
/test/cmd/hash.c: 80 in dm_test_cmd_hash_sha256()


___________________________________________________________________________=
_____________________________
*** CID 514958:  Error handling issues  (CHECKED_RETURN)
/test/cmd/hash.c: 80 in dm_test_cmd_hash_sha256()
74      ut_assertok(run_command("hash sha256 $loadaddr 0 foo; echo $foo",
0));
75      console_record_readline(uts->actual_str, sizeof(uts->actual_str));
76      ut_asserteq_ptr(uts->actual_str,
77                      strstr(uts->actual_str, "sha256 for "));
78      ut_assert(strstr(uts->actual_str,
79
 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
>>>     CID 514958:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "ut_check_console_line" without checking return value (as
is done elsewhere 683 out of 690 times).
80      ut_check_console_line(uts,
81
"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
82
83      if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
84              ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
85              ut_check_console_line(uts, "hash - compute hash message
digest");

** CID 514957:  Error handling issues  (CHECKED_RETURN)
/test/cmd/hash.c: 36 in dm_test_cmd_hash_md5()


___________________________________________________________________________=
_____________________________
*** CID 514957:  Error handling issues  (CHECKED_RETURN)
/test/cmd/hash.c: 36 in dm_test_cmd_hash_md5()
30      ut_assertok(run_command("hash md5 $loadaddr 0 foo; echo $foo", 0));
31      console_record_readline(uts->actual_str, sizeof(uts->actual_str));
32      ut_asserteq_ptr(uts->actual_str,
33                      strstr(uts->actual_str, "md5 for "));
34      ut_assert(strstr(uts->actual_str,
35                       "d41d8cd98f00b204e9800998ecf8427e"));
>>>     CID 514957:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "ut_check_console_line" without checking return value (as
is done elsewhere 683 out of 690 times).
36      ut_check_console_line(uts, "d41d8cd98f00b204e9800998ecf8427e");
37
38      if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
39              ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
40              ut_check_console_line(uts, "hash - compute hash message
digest");
41


----- End forwarded message -----

--=20
Tom

--WzOLNTOP4l0PWiK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3TD8ACgkQFHw5/5Y0
tyzKeAwAodbgbTYg6zdcSs8VpGN1o6ugwDut4Vr4mAfb45ncszC6bjp07Smvekw5
yf12kEbLK0TtTzLWkSxGFJ+uCCz48Zd9DoZ95HUFixLUKdVutu8OnG9glqkMNZxk
Bm4MnqOHYVZHZgZAejxLJhtG/1NxSc8iY6QsaT5RoHkUImIxjJgdDuMnSY23Mb9C
T1I+qFBSBpH6/rNLMoKZdvY6oQdCZF0n2BA+LrGS9FWoLoMmpp9BnvN5VqkVkWPj
0OfIxBfIFZeer699vMV26aArWrjvovmC1uxjfes8JnSDpZwYt2CsuaNKuIgD3scP
d8Hz9h6SvpoZiZhzz3Dmi4jqK3is2xPkke1vbPErzI0VVHKxJEwIxn4iQdRQ6oJM
MplKSC+3J6veRaSzr+I2OqYQjzvvbXKfDlvz6dQPxlV72g/s+eNeMzlbMmMHZZiQ
nPmMiI62j9jzjK06UlwPHoUz7rBYnMVnD0yxDWOTT0rcAzE60Wcvf2KAuNQFKQla
7cRQHbWS
=mhSd
-----END PGP SIGNATURE-----

--WzOLNTOP4l0PWiK+--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81C2EDF17D
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2DA83015;
	Fri, 13 Feb 2026 17:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OvOhEv5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7CF83AAB; Fri, 13 Feb 2026 17:46:15 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E07982A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-662f9aeb782so710669eaf.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771001172; x=1771605972; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qIU2th0vllG4Eo+8ulMSuO7WZP+CTPRF+rlqU86HUBI=;
 b=OvOhEv5dnZU/c+Xv4fHDbHiSK4zkynexXa2kafUzjkCbKhI/QaA05rQvRy62r5ShyV
 ACdUtyCaU2KvjX3GAhq1u6uaBHGvs5+83bM5499vXeMPgoqTxXn+fT8A5qRbXx9Xcqk8
 GzmBrpf7Bm9syn0u5XivnUBodbDO/kmrRigw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771001172; x=1771605972;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIU2th0vllG4Eo+8ulMSuO7WZP+CTPRF+rlqU86HUBI=;
 b=J4nknhKuDUZakq+dG3HK6gIwLDeALkxZtnL4WBW2ZNRxghDxrB1NhJyPvko+cKDWck
 hoTDtVmv0AW20ItgelTtyXD6uZq/gYmvjccuj6oybzNrIcEYaiCPgGC9Go/j+VfaSiyK
 OuM6Ak3UWTyyqsw6I0uZ36QueMbgYOLuo3zlYc+m1bcuq+bEMSwZUeozM86RMRsQvDKO
 8igwbf0OvMMJHqWV8nbtnnFHGlMAXPJeubzndgqrc4lDi4hW+q1f6BML+KApqZqLW9l7
 3UFLCthgUsgVB/x8Ym5KKsKrqV/lqri9XgUQyi9TxjYqYkWvlB2hNb2IiI4fvdqi6jZc
 MUAA==
X-Gm-Message-State: AOJu0YyxyHdiUU2LG3QE33obTj8/VkBW6h1/TMSU1kl8Dzq6JeSlohXo
 kzSDvcu9h++dc7k1wjRv3OvML6RypDCHCDvHV2GXgwvp79oizM28pwH1FLBfVI3GnKzPa8xsdzQ
 uqGbIwWA=
X-Gm-Gg: AZuq6aIZrD7F7n0Ib1LLgnwzg3a36p9ItvjJ5aT0NVOzVbe4MqYh0kHzFFl/+RYkSfB
 i8XbPloTq4ioMwOGgO2Ieyk/C9SSMzKe3yfrc6b+a7aOgSZYOa4mFNyRCVWHYHZb3WlKDavG6C2
 pPlf8Pb7Pb9GqE2jFida6xyDjQI5qDh5U4spc5XRqFdrbzoI2vZ01ZJaMMQ5ODj23WiSAc9SFda
 zL6wU8UGnC1E630upKJo1LhuyCBwMKAjoY7pO2kjwhqYECpBgzYfP1A1LZ5STGmZipP4RnG+bbF
 1BjYUyroTGu3cAAH8E/l00VQkXycmUubnmPYzVIRFY59wBMJ3hkgkaktH0weHCQhozG191qVxCi
 vLXImymJFcNcY91xSTX9SRBbaIo8Fix7LLJ7FpL47WZj7CdAUg1v0mIdHDb2Hdmk/1n6FgDdu3f
 atk9+v1dmz7WBYtNr/uH3YD9tD976unpTFG0b60GVqMKNPSUMrKCDJ8s9BhpjtFY2N7+hEejW3J
 G5z8OyXR3SObxVv73ocCFg3EUs3gORbatUdKPTSOgVmsVDLby8=
X-Received: by 2002:a05:6820:4dc3:b0:668:d715:1098 with SMTP id
 006d021491bc7-67722c5a5f7mr1153004eaf.59.1771001172124; 
 Fri, 13 Feb 2026 08:46:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674737d8b6bsm4178316eaf.8.2026.02.13.08.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:46:11 -0800 (PST)
Date: Fri, 13 Feb 2026 10:46:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: [RFH] SPI and SPI-NOR patch help
Message-ID: <20260213164607.GI2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nefvMJ3rGb/t00Fc"
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


--nefvMJ3rGb/t00Fc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

To be blunt, U-Boot needs help with reviewing and maintaining the SPI
and SPI-NOR subsystems. We haven't had someone with time to actively
work in this area for some time. I'm going through the outstanding
changes now, but it also seems a common problem is that with respect to
device IDs, most of the new ones also aren't in the upstream Linux
Kernel. Is there some better and generic solution we're missing so that
we don't have large and often growing device ID tables? I'd rather not
make that problem worse, so I've rejected two of those types of updates
today and I'm just setting aside a large number of others.

--=20
Tom

--nefvMJ3rGb/t00Fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9VSAAKCRAr4qD1Cr/k
Cs9WAQD9IjFA+RjsPCF2ghdnJr7zbFcd/HXigKH8GxEx79TXPAEAoSOJ9+WWCE28
6+Ed4OTu6tiv0RjE+gSFomrAe5/MEgQ=
=LkWi
-----END PGP SIGNATURE-----

--nefvMJ3rGb/t00Fc--

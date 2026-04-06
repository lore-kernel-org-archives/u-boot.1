Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9904FFB5189
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 03:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E364B8341A;
	Tue,  7 Apr 2026 05:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFUYdT+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061ED83EC6; Tue,  7 Apr 2026 01:38:38 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48768352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 01:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anatol.pomozov@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-6058b3ec384so1271599137.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 16:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775518714; cv=none;
 d=google.com; s=arc-20240605;
 b=X/sjjH1HuLfdEcB6n41LiGHGUmOj3J0uQn2T+/TDdiwSf99GSnn39fPny0eq13U6zZ
 5JNqk9Ww1an5Ov0ehGaWHcZD5d7aImoc1DLdLCafdp+AxB32HKciMl2kTS5kdgg+XRQI
 DCVnqbG2EhvsDABjwyADS+2ce5m7miSfWWNbWmmN76XuiIxut6FAzaN5MaMoIWPDkHSU
 Sy/BhqGgbxFUvpOK3v4qKBy65yyih44z70MU+OdYKed60GhbV+ETa0uQHEQKoyEWW9VC
 sRCAWFGWsq15IJjzvMGVUUFcE3DmcQ+vjYngsahYefWIWSdBRIMYQHYvazawL1a/0Pbr
 m+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=XoG7AKosysNBCyqpurb0tJ+aXh1fnAf/oeHPOdVkoFk=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=GlmJt6A9TgeRu3iDhE3SA+t1quFWmQXcWSchceWBhKD6m/AqkHhNlYzOy7KBTKty9I
 4a9NrF4/HJw+vcOGirWH0wf5VmGJCuSDyIIbvk/9o2V9tzOQtDPiNk8qpfkBamfyztvX
 6OZkVFwLzWm2UPKgaUE6W0Cqe3J/VYYWpvsSQogVUlPy6EFKcSr64Fg+HzKasJHbBdGv
 8leN449Sv+QCA/IakZk0XXNj8Ud/ouzbOzJN+Ougp4j9ZS6cNUs58ikb0bDL8w+oQzuI
 uRFWZ9RM5HNX+HwwTZclFbMJPZ71+vyZvh8aDhhfZYXGVL/TZT/SVno60c09HXw2REB5
 7uBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775518714; x=1776123514; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XoG7AKosysNBCyqpurb0tJ+aXh1fnAf/oeHPOdVkoFk=;
 b=iFUYdT+kLl42wtSHH1tJ4XoeBtMJyLgnSFUVnq8buTx8yaLg1JH72S1RkKoRMFBxho
 5a7NE+QtB7VVL9xvosDuJ1DXGWQc7hi8yETFeDK9RF5dKVHxtFXnO1So7fzhvoEuWxXz
 h/mIZTiavMGuzM47eMhsAFqb2xrYkGjiePKj0knYlbXY91UNmeoNVveX0ioS1i/AuBF+
 aLHt5I4ls4MKa8SvAH6aZ4tjl//VgB5pdBKKlWufk7Y2t5tpJc5tPrAPteKYT+VMrMlL
 DRY/NbCg8qeRdtduNKdawfuUqfv6n38aAXAv/BgRG6CDxCQl4LC92HHQIZtdx8w8VOfC
 IbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518714; x=1776123514;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoG7AKosysNBCyqpurb0tJ+aXh1fnAf/oeHPOdVkoFk=;
 b=XSPL8XL9xhXVLSX/OERG4NapYvm2bsht0H6MMTYp9e/Ar3XW9Aw4OwWga/n10WTOKG
 ARXrYOEr/+YdMP4j5/mGTlmZ3jZCiWR2rt9AfOolW+UDqstStccbE0vgsVNPFUYlmoya
 YcAAELWyS3i8ZqFPiZ3Tjrv4JwjPoFSR2UJtHaVmd6rDfbTrYVIsbD6s6atJUva2N2cV
 1ALusdLznSWU+J4EIiD3iPhXDUS5wkPvosUliV7D8ChaQEzFokAOVC9A6RqBJPiBkWOI
 2Lwdda+M1Tl8mBWqZPNQAvWwX/vcEaBKeWRtw6+VRvNK46xcqzF0shLIpZ9uDeUH2VAt
 iQDw==
X-Gm-Message-State: AOJu0Yz5GRocpoJY+O8rl1pT4bDHhdASP5dWx/9+jTMjZJEuu67jZ7Y3
 fZvodaGaIU97u+cST1AsIgEW4DMDDJpOJveBTgTrT2o6SSxoPppoIJOQQsQjf+Id1idgQ6hOrjP
 4DGIixnvdKBbWGIx+LUDNvTIx706RbX1mnpuy
X-Gm-Gg: AeBDiesXG9Zr8c0ucAV456yiuuXbwTxdcHxgi0Sx70lzh25ZYlYZNqMvZbaarFhnDEM
 uirduxSLcdEEPqJxejphtIdBYYCj8kPGEfaIVzt6KFqRfpG4YuE6wEF7SsShTXLwGKfKG+3MZcX
 DfTENk3W0A5YkirmQgsGpyGhP5s/zzSr90l9anTauol6raIUeqkyaLZV9QPBBBjLolZDoTVNhlb
 ZqvfzO3QPogevu6vqdDHxu50STP6zko+o2aOncRJO9ll37Rl7yYCQINeCfiE/krIuYSw1JsZ8R4
 V+9IM6SQLwysFRH1+6V9gf/LIrnsMZNbuoXYdO1tb94UbbqFJiafd4uplZZoPAy4/LBIs0c=
X-Received: by 2002:a05:6102:689a:b0:5f9:39e9:3562 with SMTP id
 ada2fe7eead31-605a4dd9a49mr5009612137.2.1775518714138; Mon, 06 Apr 2026
 16:38:34 -0700 (PDT)
MIME-Version: 1.0
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 6 Apr 2026 16:38:22 -0700
X-Gm-Features: AQROBzC2VMJqGLh7op_RwnKTTcxZlTrBNKLs5b5dhfPv-h5Z8cBnC-J48p5wrP4
Message-ID: <CAOMFOmXFjh1rXWb7bacrLHAZahe6tcyEyjYAKv5=SHP=dJf3nA@mail.gmail.com>
Subject: Switch ARMv7 Cortex-A processor to ARM mode right before jumping to
 target
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 07 Apr 2026 05:01:00 +0200
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

Hello folks

I=E2=80=99m facing an instruction set mismatch issue on ARMv7. The system u=
ses
a proprietary U-Boot=E2=80=93based bootloader (based on v2022.07) that runs=
 in
ARM mode and then jumps directly to my application. The application
itself (Zephyr-based) is built in Thumb mode by default, which leads
to problems when execution is handed off.

Unfortunately, I cannot modify or rebuild the U-Boot binaries, as they
are closed-source in this case. The only control I have is through the
U-Boot environment (uboot_env).

Given these constraints, is there any way - via U-Boot environment
configuration - to switch the processor into Thumb mode right before
jumping to the application?

If not, are there any recommended workarounds for handling this ARM
<=3D> Thumb transition when the bootloader itself cannot be modified?

Thanks in advance for your help!

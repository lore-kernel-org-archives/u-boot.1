Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50779606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aQxoQwFc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4VasWUD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 225DB60A59;
	Fri,  6 Nov 2026 21:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IyhyEJys8r3c; Fri,  6 Nov 2026 21:56:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11F3060A48
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002185;
	b=LVw1n4FNSr6yljOd4zLNK03hmP87lAYZNXDL6VGN9aDfFTSFN6GuAUYmxSo4V622R9Rb
	 iY12Iy47D55BYc/NCdM6QDq2/wCmEWNtOet5GinADgEbWwp03JfErrvvh/ldeuLxvwQq9
	 aEjoZbxnfBz5ZyP6BQWfukmdUWK4joVIWLRXKM0jUXDnkdcgOHNatOJo8n6yyyf/yHf1A
	 NT7AWPqxcw2q8cb9QahCq7APCbhoA+X7UepUU6bnM7lZI+HwUPmwK8zAztosmu/DcBtv8
	 q2jh/kzx4aWXABHFJQ59yfiTHC/Z7mM1a11E7Vk2eDbCoNl8rCjqdFZHnGu344W7zFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PhcZ7O/bEIxHflQrmBRZFLE4DqNQ9+V1MgGUIuZ1d6k=;
	b=DSlkZi/XMahjWR4Ots+UQLb301XrPCVS7LGm2Lag3GlO8pJTjBGEW+o+vN0FKvhXBO1i
	 5CoGFiIcz2vLRuMWKkdLcfrDE/9qSXs7gZR/sUhK6P0weEcL50sdfmJMVX5Rh4nYcOzos
	 IDsgTpsQvNAr+Q08q2zyQpGzsH99kWmyGWnCATeILxzZXYH2sSopbiqU0FV4dAHX60iE9
	 8an5O6gVm/uq89Dys5qwfwuE9jBmVOSYOu+ZrhRaPTx159LOIfL3LEpdaRnOSyFc2cpXd
	 NlZv05vgnYis1gUFVnLaYttEcfiUXr39EpniWn6ORzjECX0tC2AwoNxMV2shR/4ijUA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002185;
	bh=PhcZ7O/bEIxHflQrmBRZFLE4DqNQ9+V1MgGUIuZ1d6k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aQxoQwFc6cXYIGYZJAyfHnOxeTGcGCzA1wBorpq5XlCKSE/M1HTUcex9JuLjSIBvJ
	 2I6ea8euPYoLb7zbQER8TuHf+HvTDWi/e7bdVUmPf1gPGAJQvhXNx/0mA5R5nEot/i
	 RwZNJb97tlkfnsvTdh+PtGNvtXaKFW9jEwr8NjWj6rkY1+2DuE7NABdAfw7ljHQpvK
	 L5ZTUcC/NW6J3YYb4NXLs78km9X1KxiZu7b8IJDhJwj2Hai5jMc/j7KxDKmvXBclyj
	 esKTnenCA1odsvvL5tM1ISsj63IeNpwKQDplPaubTDIBrCRwSOFRh+SDEsOA1PIWE2
	 j19zmiqh4pMHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11F3060A48;
	Fri,  6 Nov 2026 21:56:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C13E131F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6A8A80F55
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUMlwIA6c9vV for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8716A80F50
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=p4VasWUD
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8716A80F50
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:22 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so7405955e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002180; x=1794606980;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PhcZ7O/bEIxHflQrmBRZFLE4DqNQ9+V1MgGUIuZ1d6k=;
 b=p4VasWUDs8/h1WOw3u97U/wSObrar2EYszC9DTDxUrzQjiQJKqWjY/n9COr4uFZSX/
 NB/GPiHqUwWmS8utLNL1lH2oR3nvTHfNXtkfHtejri6WdI77e04oAWC5+OfHZzRmdDjY
 dQMMTBvGuUiy6v8opGuC01WkGlNd8C0GzkMqmzRFD6z99eBWYFAK1Iyozwid6rVHuuw9
 SHWsRdHuKUD9fnjdaNCwf9D6lTWqTJKyG7qv6MlyUmNDY6sgdavR3m8MFcPAy97ceUwf
 LSTp1gO12iYN5xRWjxBaAvaamA3BWFiP9m0a3x0JfVI4DBM8PXrxxrHXPV8tcDJB2IPI
 a9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002180; x=1794606980;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PhcZ7O/bEIxHflQrmBRZFLE4DqNQ9+V1MgGUIuZ1d6k=;
 b=NQ/cv+Jl7JnZXgBAxxfjTq1sy/mlbcQ9K/mtySsxbhzAiQyX8IGKwyxJJ2PmYLNAlW
 TmM2+yOAhpk4nSfH9ZnnYd50t2Dx9IY1hpXMZOQb8uZDK1ZkfUImZJnSDM5Ow5/lZR/8
 KBYTvJrTbjLqfgfQIF7xZZhUPs+XYXr/qVH0uHoZYp+UUo3gfeT1CNrN8urZCqzQDXGt
 4ERmPWy3yUhpPFaXsz7z+Hhq9XazPqjqbHFWoj5sSa2bV3RiJQ1XD+DyVZ5lIKVyINFO
 qc9uJHjvaDqC2voNbE9S5xX51rMb88IL6EHyRw1pu+1Qz64b89x5S6eLhNhMpsgfFhYo
 UonQ==
X-Gm-Message-State: APuU4Z+EUFWUVDwzbximWzT8E1Bgir3sdoL0pIUbCR11e7VtuKTq3JB1
 0IUdJ5NRUDU1oU99ye2ISHdRRGTsoWNUKn/H46cT8vJngEqn5pUKYlQVc7IrHUeHEyU=
X-Gm-Gg: AYBFou39pT93qo4S7jFywxz0WC8eC/S9uJ4mgvW+4HocEnLD+9MyApDNFfbx+7RfztU
 BR5sZ8lYPOElA0iR1siPHX/z4hws4XHokSSIoEV33037osUh3eTz89uDWI7ilTTipxaCG3/JSXm
 L0iFU0bjZmswOYGtGX/EgfeFCbQxe+c5XERmsIaBchofzDENBQSdCY2unZsA5GYzN/nLIo7OGVJ
 HSE+oFLiMh9cxiwFYsdg0Iqa2W2QgY+Ep9b0N2iOEJODGsFli0xP2txZOZEpvRPV86e7lwvWwY+
 gn+M9vh8MWuunoBQbyYd0l/0o3vmmGRgEyF0MRv++CAZEOvnK03A4R71gRkVDswRvcVVngL6Fik
 +zNKF/urpyNfObZxzC+XpAXforCjLhcBqANRivZjaJSSscSo4vKxSM//V5kC1OzXuzjKG17Zvgn
 jDAkni7Gr7XckXZTafh4cOiNMUuMxuBmhfBljTQRjEzP0fNDRN1lXB6WK7MeEY0Gp6jNoMW0V5Z
 6uuAaUdsSlQ/tjWTwh7PRTe451Gwxl+azCOmohKWAYYoTMghUVpdRxGdu5xd+rIBW1+iiokiMkW
 ffX+oktDtGIwN3vSnMqnbB0WxXERBvo=
X-Received: by 2002:a05:600c:630c:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4b6d82b3d9fmr69794455e9.0.1794002180004; 
 Fri, 06 Nov 2026 13:56:20 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d723320csm5456130f8f.26.2026.11.06.13.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:18 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 00/11] efi_loader: check PE images before using them
Date: Fri, 06 Nov 2026 21:56:17 +0000
Message-ID: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

U-Boot takes the offsets and sizes of a PE/COFF image from its headers
and uses them before it knows whether the image may run. With Secure
Boot on, efi_load_pe() authenticates the image first but goes on
copying and relocating it when authentication fails, and only then
returns EFI_SECURITY_VIOLATION; efi_image_parse(), which collects the
regions to hash, runs before the signature is checked, and so does the
walk of the certificate table. TCG2 measured boot parses every image as
well. So an image that will be refused, or one that is only measured,
can make U-Boot read or write outside its buffers, or hang.

This series checks those fields against the image where they are read,
along the lines of EDK2's PeCoffLoaderLib and DxeImageVerificationLib:

- patch 1 has efi_check_pe() check for a 64bit NT header again, as its
  comment says;
- patch 2 checks the headers, the sections and the certificate table in
  efi_image_parse(), and fails on errors of efi_image_region_add();
- patches 3 and 4 have efi_load_pe() reject, before allocating the
  image, a section whose end wraps around and section data past the end
  of the file; patch 5 makes room in the loaded image for all of the
  headers;
- patch 6 checks the relocation table against the image;
- patch 7 rejects a certificate table holding a certificate no longer
  than its header, which could make the walk loop forever, or longer
  than the rest of the table;
- patch 8 refuses to load an image whose subsystem is not one of the
  UEFI image types, as EDK2 does;
- patch 9 marks an image whose TCG2 measurement failed as not
  authenticated, so that it is not started unmeasured;
- patches 10 and 11 add unit tests and a Secure Boot test.

Patch 9 no longer needs Heinrich's "efi_loader: handling of missing TPM
in efi_load_pe()" [1]: the series applies to main with or without [1],
and [1] applies on top of the series.

barebox, whose EFI loader is based on this file, made several of the
same changes this year; patches 2, 3 and 4 follow them and say so.

Valid images are unaffected: the unit tests check PE32 and PE32+ images
with 16, 6 or 5 data directories, an unpadded last section and a file
alignment of 0, the EFI selftests and the Secure Boot tests pass, and
each patch builds on its own. Tested on sandbox.

v2 passed U-Boot's Azure CI, all jobs, with [1] (build 13728); v3
changes only patches 7 and 9.

[1] https://patchwork.ozlabs.org/patch/2335140/

Changes in v3:
- rebase on current main; patch 9 no longer needs [1] (Ilias)
- patch 7: fold the new check and the old "dwLength too small" one into
  a single check, which rejects a certificate no longer than its header
  or longer than the rest of the table (Ilias)
- patch 9: put the new check ahead of the one for a missing TPM, so
  that the patch applies with or without [1]; the commit message says
  that an image is refused when no TPM is found, which holds with or
  without [1]
- add Ilias's Reviewed-by to patch 8

Changes in v2:

Ana Bobillo (11):
  efi_loader: check the NT header size in efi_check_pe()
  efi_loader: check the PE image ranges in efi_image_parse()
  efi_loader: reject a PE section whose end wraps around
  efi_loader: check PE section raw data against the image size
  efi_loader: make room for the PE headers in the loaded image
  efi_loader: check the relocation table against the image size
  efi_loader: check certificate lengths in efi_image_authenticate()
  efi_loader: refuse a PE image of an unknown subsystem
  efi_loader: do not start an image that cannot be measured
  test: lib: add tests for the PE image checks
  test: py: test invalid certificate lengths in signed images

 lib/efi_loader/efi_image_loader.c             | 369 +++++++++----
 test/lib/Makefile                             |   2 +-
 test/lib/efi_image_loader.c                   | 501 ++++++++++++++++++
 test/py/tests/test_efi_secboot/conftest.py    |  31 ++
 test/py/tests/test_efi_secboot/test_signed.py |  36 ++
 5 files changed, 833 insertions(+), 106 deletions(-)
 create mode 100644 test/lib/efi_image_loader.c


base-commit: feb8913982e4462c01fd914271f92254a25dc101

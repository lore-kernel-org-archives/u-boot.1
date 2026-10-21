Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B1606B6F8
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hoMpMVCG;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q3ARbL+v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACFEE408D7;
	Wed, 21 Oct 2026 16:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QyQBQiBZmLet; Wed, 21 Oct 2026 16:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8666240877
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792599265;
	b=IdAlOPR8Zfth0w+se7h9FHzEuhy6iJy3SIXiKX8w5sbrqIPj9b+DjI37ZH4PTCUUINN6
	 TSIPEKh1ou0cTRtoxqUzPjFI5PZFa0mjY2rcNN9U6oO4eyKtG2+Y7SQ8mGJAldsfktArD
	 a/jIdTXhh45b9Papnw57ALsOd9ORRcfvnRiF2KfgGThwLeelLBGrY4oQmDBGMxdSQC+aZ
	 hnVqlwaO+CRUNZSTswBEaxSW8ANV7ynVlTOZGPa0tTTdU9oJK62rbceFYqFyFhd2SJY0a
	 op066gqmPl4nSnjQQucZzNNc2lRD9EJdilxqd0ZgZjoxPUZ3MSCHuNcsdTblu2qOhsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
	b=Eu9S1XsfUCu7uU1cQqRTCn/xwZIbdJ+ChhAtpL18KX0zigNkihzu0Hrvv+8ny/vhZQIb
	 KxiltW4NcoWO1CqWqxacH71Orq7i53fbu/zQAyX79OiVRGzH0STvTO8v6SFuCJY80C2v/
	 tYajNhGWuiKEh1rYP7MkBinGClu973BVMK/0CWaZCBO+gf6nvO2xu4CuDXPHPnAlS0PnT
	 aU0jat4FIvN23y00woSDLqeByQ/8UiB9jKc6ZJmvw+cbSfl70hg3oXq6sUgpUVB4vZGRq
	 6FArqQTafocUP9WK3OYwf0JCCQxsAWt+MmSJlbfbYgLKpqeD2oHFjgGEKgZ+esDs6Ng==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599265;
	bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hoMpMVCGAmdWErqXLHPWpNp9NyBNT4knowgfyxJc1ypYDnXPtYFjDzPImJRh4wpoR
	 B20jnINz/tP5SShzvCCXsltNabtDcSSSVgl7PXyQhe/Zd0mG+UlIVineH1Cqcfd07/
	 lQ7EeqM1N9hWq2QGnA68SBEyf1P92muE1K53k31wCmAqpXJZvqOxVqc6xWpLE3oR5f
	 Ck/GRE7j+t+bA+g9ticE6HEcMuwLCYKNEr/6FA+yxh1YIYteQBSy+qyG7eruu0Gp/e
	 TKPqTElRVLK/3PPmlZluQyrEdrowSJsekADyHRzjfKSPLdHJYoq+UCA2GLC0qoeVDC
	 hNeM84sTjEYKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8666240877;
	Wed, 21 Oct 2026 16:14:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C27E95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69AF0605FC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smjolxzHUUxe for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C63D605C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599262;
 b=tOHaqLZDU5T3nZFy/im0/ljyHm35Hl5r4djYmkZuGXyD4PlyFKNvhRMTqpsvOokpy2V2
 txiZrymyfeKmsayaxbYiPr3Dbq1vFBsjoc6fKyWlRZrow7YMFJX+EbLBbmq6Nzjy1cArt
 obunCgLvaKSU4BwwQc7FVC8u8jNDOr2LrJ5yL1rO1MQ3z+ieI8TCoEHM2ItevE3lCRUsO
 7IQregH7LkejtjFesL2iLs1kdj+ORNagvA8zThoEgKZBoAlux9ouwQCP6OMbcMRoYEmSU
 4MurwAXQZo87FoEZ0Le2gn+eiVRMLiAcNuOg3nqIDvFUG7Y1HEYfSZCD3u/5Igigm/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599262;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
 b=k1TCIbWhsVYAmRD9frrqrcadEOaO3oZhXwYb3LU0hWPu/biBfXrdq1LCsVW8lu40S9qi
 iUgz89nS2dX2sMH9qYMfkpCCZ8XffoEf1YTnSbpNh5xuov7QZySgW68rRlrdDPopCbstM
 LQkMCPW4HBl0bi1SNqdNHvSBLnIwT61VamaSUG5Tnv3v4fUbhwLVvledSEwy4yWZG9Auy
 WXJUyXluRN67uk8PpHejX4fazA0lg2Edf+AclKfBqbzJy5vWmqx1ob3ULD0Z/CfthDaqL
 Wx+u0+gKF8k8KrNcX9dMbs2HfFJ2qo/3OtRrkO3jU2pXfUTU952X8H6GLIl9kuLy9bA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q3ARbL+v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q3ARbL+v
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C63D605C9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:14:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5976844F6; Wed, 21 Oct 2026 18:14:17 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DB98056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 18:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-53397554beaso9929721cf.3
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 09:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792599249; cv=none;
 d=google.com; s=arc-20260327;
 b=fKKb48aFYsjpXIdurmhmpJSc8BUNkgLkMpvfQVYLRS3pNITrcsyl4j0g4ycnHp/DsZ
 7iM5iuiLjke792qKuaJ5GVwq4b8cmCGpG+0dzdXwxdCUOlAfNI0nwX20PQBBztoRgpgc
 pVK4aDg8g/C0XWNMApemw5N8NkTQowrUToIrbpxbcyDxdc/nbBHB402pqzFHIFOrM84K
 WV7ppwwOXFqlaGjsoL+O2NLjeKOazb7u48D/F+VmkhU4sdiJwh4+7IrqLI/5InW/JGg8
 JAvsEdF8tngr9ao1R3lLFcWVAWnAhHMvW1eAucvegrSEWbRNQ+HsvkOp1tRqFxzkKJGs
 HLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
 fh=mqqWf9ooTNzdmU3babZXMLDJGOkW3TBqVv8Kl37Bvdg=;
 b=sR4QLqUlrAapSknDgo19IUj0X4upKxUeDTq1/zuLUmwn8KZgaxZig9SVmN4KshYofB
 qFIHK4a9VxrC4G0gs5MHCMfcAH371df6Ve9g92wjKPV3ukzesI4a1zsaul0vXx4tw6gk
 DtDxSgWL2AE79oQbsN8Pk3/sBOvGu5gy+p2xXzzi9jvZkJsiZbjqBVZnGjKJSMbZipze
 UDC7rM11UxSdUM+aXasQbLoKVT+VKANTytK9gYWPQMsnOv8Qpr9pkiMRIz12VQwVJ0zU
 njeYdQ9/KVdOdOae06+Z3gkt6tuZNIk3zJse/TAQWIGu6AAyLIVdBve/Ln16we6o69Ei
 97lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792599249; x=1793204049; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
 b=q3ARbL+vlbOMSLffij5YYWe/ilOLc2iT7BFUPAXVp5bxKHifSE7sutTPtQ/AWiJH4+
 puE3JbMnbycCHULIlAaXuGDENH/iDwCFrZt6Rzl1NrgCHykLW2ZsBZF584XVxZyGSs8e
 6uMeTF84qQnZLIoLOjI5476uBCDhn4EgJxcWRBP0fhqDUAUwZ8q1IkP6Zeh0o1/b6RWV
 i8XFjBbouWY+DTknjbaUqVhBCPNp7u8/qg+OsfZsMhDlbPKVcvTw7PGDHiNaUs+PfCOd
 wA+8+LWTSUt8KyqAfCpQGzwTBpKq1Nhc5NydQmxBEk1h32RiHMvkqqynL76yl2PKpSnh
 G81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599249; x=1793204049;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F4HuyVLw6ASzX12v7AfmPZGhJEogKoK5etjSQ2c97uY=;
 b=SaITdUVQMzfuGC0arFSsdDhC/wgBoJeUdDlcDn7Dktfswz+QvT+m4fDHw6tLZVgNZo
 xnwNUaPdX63dK77NSDjkTFVVyAxPB5KMuw53J92lGIkhLWD3zT6+bU4gO+XCpJ6K3XVu
 2j5G7Ur5KeiNcYEqv56pqdHop6KYw9wxgwaE4kwTY9ig6DGuJQ/n4s63URM8GVHb4pER
 SAYCR76Eotq4w4w7ZG+1TfyUZzFLstEVy+b9o3x93KYSZz+pNiBD3Eu1sR3+H6nHzDNL
 W3FUzx39M6XyczRcqzdQBo7Oh+x9uW7ogjZ3Hb09VuAfjkaffkGHk9FYXA+GiphPx6ij
 pdHQ==
X-Gm-Message-State: AFq9FYINao/xbl5CX4NAgrRysP8MXlJ23v2djOWzLIIDfTlSUfL07IU5
 ZS03gQ+L0IaGlKh+ykNO8kFzKSgTK9V+u/VYyHt4W7CMDsfDPEuCBvGluCYNpaB9eQBqt0JG/Cd
 VXArTb2RKStEwrJdmW4UvbocDXfWE1Ls=
X-Gm-Gg: AYBFou2ate2D4T11i6PU1Vm7bRFu+vzcnZ5T3CNsT8mmKhiYRzQbZqwxeSVtcaqH9Sk
 EsRJPmw+90qvm3eLNTwjin/Vgv7XlSlGPaScCMA2WNjj3+8MSznDCCTrFBkDaKoYh9q60Uf6I2/
 ffBWeVUx666VRHHBd0cCuOF5ZegMYjQgI8qMkeXDlaLNeQOAy7FdzTafuKSB1hu2F7mg+DjXkww
 YtunLhq0ZsCreksHn660q8tvzhNnjCHuxgQE/+c7pqoMRTH5aFGeZd9Np0itSn3kcsbQoNFk01/
 cvY5UNokKC0Of6diKrXvA0FVHlJTFp871+vXfryvlV0kmqBJe6ZK5sfwhUsQlQfux4jQ3poLZO6
 ZHkJehvzgAdC8otvNsEWVFz48i+f2IuS5uf9W2lO+jgKcvYOF/TwoJ1TTEAaQtBjLn/KJWAAoDa
 EdYxK6guR8U1YvfKbzLfvXeFLNT/XWg9+UC5pKMga62+Gvz4NvnfNXfNXmCs7o10OCqXsIukKSs
 VIKIKOQUuJxo1sONQRX2yalvl5pIZHL22WZmqhebJgfnBCG5bavGxeS
X-Received: by 2002:ac8:5cc8:0:b0:535:b506:11c6 with SMTP id
 d75a77b69052e-5369b7e23femr38358261cf.57.1792599249100; Wed, 21 Oct 2026
 09:14:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-4-bhargavdas100@gmail.com>
In-Reply-To: <20260902211501.127915-4-bhargavdas100@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 21 Oct 2026 17:13:56 +0100
X-Gm-Features: AclHuK-9J_ydK6QAhDHXXZti4C7Jt6RqCdiT_fP9wyKdH39vbG9AW30k97DtEC0
Message-ID: <CALeDE9MFJEZLVf_eOHVOL0HCnV36=ZGHOn=4hi-RJGMO9iGXsg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: raspberrypi: Add Pico 2 support
To: Bhargav Das <bhargavdas100@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please don't reply/thread to old versions of patches/series.

On Wed, 2 Sept 2026 at 22:59, Bhargav Das <bhargavdas100@gmail.com> wrote:
>
> Add board support for the Raspberry Pi Pico 2.
>
> UART1 console is functional as of now.
>
> misc_init_r() sets a fixed value for the "serial#" environment variable.
> This fixed value is hardcoded as just a placeholder to confirm that
> evn_set() works post-relocation.
>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
> ---
>  board/raspberrypi/pico2/Kconfig     | 15 ++++++
>  board/raspberrypi/pico2/MAINTAINERS |  9 ++++
>  board/raspberrypi/pico2/Makefile    |  3 ++
>  board/raspberrypi/pico2/pico2.c     | 81 +++++++++++++++++++++++++++++
>  configs/rpi_pico2_defconfig         | 29 +++++++++++
>  include/configs/rpi_pico2.h         | 36 +++++++++++++
>  6 files changed, 173 insertions(+)
>  create mode 100644 board/raspberrypi/pico2/Kconfig
>  create mode 100644 board/raspberrypi/pico2/MAINTAINERS
>  create mode 100644 board/raspberrypi/pico2/Makefile
>  create mode 100644 board/raspberrypi/pico2/pico2.c
>  create mode 100644 configs/rpi_pico2_defconfig
>  create mode 100644 include/configs/rpi_pico2.h
>
> diff --git a/board/raspberrypi/pico2/Kconfig b/board/raspberrypi/pico2/Kconfig
> new file mode 100644
> index 00000000000..eb06fe6baeb
> --- /dev/null
> +++ b/board/raspberrypi/pico2/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_RPI_PICO2
> +
> +config SYS_SOC
> +       default "rp2xxx"
> +
> +config SYS_BOARD
> +       default "pico2"
> +
> +config SYS_VENDOR
> +       default "raspberrypi"
> +
> +config SYS_CONFIG_NAME
> +       default "rpi_pico2"
> +
> +endif
> diff --git a/board/raspberrypi/pico2/MAINTAINERS b/board/raspberrypi/pico2/MAINTAINERS
> new file mode 100644
> index 00000000000..e081f894e00
> --- /dev/null
> +++ b/board/raspberrypi/pico2/MAINTAINERS
> @@ -0,0 +1,9 @@
> +RPI PICO2 BOARD
> +M:     Bhargav Das <bhargavdas100@gmail.com>
> +S:     Maintained
> +F:     arch/arm/dts/rp2350*
> +F:     arch/arm/include/asm/arch-rp2xxx/
> +F:     arch/arm/mach-rp2xxx/
> +F:     board/raspberrypi/pico2/
> +F:     configs/rpi_pico2_defconfig
> +F:     include/configs/rpi_pico2.h
> diff --git a/board/raspberrypi/pico2/Makefile b/board/raspberrypi/pico2/Makefile
> new file mode 100644
> index 00000000000..a2929172d0a
> --- /dev/null
> +++ b/board/raspberrypi/pico2/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y  += pico2.o
> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> new file mode 100644
> index 00000000000..c11e7ea2e55
> --- /dev/null
> +++ b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <dm.h>
> +#include <env.h>
> +#include <init.h>
> +#include <log.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/rp2350.h>
> +#include <dm/platform_data/serial_pl01x.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/*
> + * dram_init() - Report SRAM size to U-Boot
> + *
> + * RP2350 has 520KB of on-chip SRAM. There is no external DRAM.
> + * U-Boot's "DRAM" in this context is the on-chip SRAM.
> + * We set the base and size so U-Boot can place its stack,
> + * heap, and loaded images correctly.
> + */
> +int dram_init(void)
> +{
> +       gd->ram_base = RP2350_SRAM_BASE;
> +       gd->ram_size = RP2350_SRAM_SIZE;
> +
> +       return 0;
> +}
> +
> +/*
> + * dram_init_banksize() - Set up memory bank info
> + *
> + * Single contiguous SRAM bank on RP2350.
> + */
> +int dram_init_banksize(void)
> +{
> +       gd->dram[0].start = RP2350_SRAM_BASE;
> +       gd->dram[0].size  = RP2350_SRAM_SIZE;
> +
> +       return 0;
> +}
> +
> +/*
> + * board_early_init_f() - Very early board init (before relocation)
> + *
> + * Initialize clocks and UART so we have a console early.
> + * This is called from initcall_run_list() in board_init_f().
> + */
> +int board_early_init_f(void)
> +{
> +       rp2350_soc_init();
> +
> +       return 0;
> +}
> +
> +/*
> + * board_init() - Post-relocation board init
> + *
> + * Called after U-Boot has relocated itself to SRAM.
> + * Set up anything that needs to happen after relocation.
> + */
> +int board_init(void)
> +{
> +       /* Nothing special needed post-relocation for basic shell */
> +       return 0;
> +}
> +
> +/*
> + * misc_init_r() - Miscellaneous late init
> + *
> + * Set board-specific environment variables.
> + * RP2350 has a unique chip ID we can use as serial number.
> + * (Full OTP reading requires more setup - placeholder for now)
> + */
> +int misc_init_r(void)
> +{
> +       /* Set a default serial number, rpi pico 2 part no */
> +       if (!env_get("serial#"))
> +               env_set("serial#", "SC1631");
> +
> +       return 0;
> +}
> diff --git a/configs/rpi_pico2_defconfig b/configs/rpi_pico2_defconfig
> new file mode 100644
> index 00000000000..51e4361fdbd
> --- /dev/null
> +++ b/configs/rpi_pico2_defconfig
> @@ -0,0 +1,29 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_ICACHE_OFF=y
> +CONFIG_SYS_DCACHE_OFF=y
> +CONFIG_ARCH_RP2XXX=y
> +CONFIG_RP2350=y
> +CONFIG_TARGET_RPI_PICO2=y
> +CONFIG_TEXT_BASE=0x10000000
> +CONFIG_SYS_MALLOC_LEN=0x8000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20082000
> +CONFIG_ENV_SIZE=0x1000
> +CONFIG_DEFAULT_DEVICE_TREE="rp2350-pico2"
> +CONFIG_SYS_LOAD_ADDR=0x20010000
> +CONFIG_SYS_CUSTOM_LDSCRIPT=y
> +CONFIG_SYS_LDSCRIPT="arch/arm/mach-rp2xxx/u-boot.lds"
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_PROMPT="RP2350> "
> +CONFIG_CMD_TIMER=y
> +CONFIG_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_EMBED=y
> +CONFIG_NO_NET=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_PL01X_SERIAL=y
> +CONFIG_TIMER=y
> diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
> new file mode 100644
> index 00000000000..b5236320344
> --- /dev/null
> +++ b/include/configs/rpi_pico2.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _RPI_PICO2_H_
> +#define _RPI_PICO2_H_
> +
> +#include <asm/arch/rp2350.h>
> +/*
> + * Memory layout
> + *
> + * Flash (XIP):  0x10000000 - 0x103FFFFF (4MB on Pico 2)
> + *   0x10000000  Second stage bootloader (256 bytes - handled by ROM)
> + *   0x10000100  U-Boot image starts here
> + *   0x100F0000  Environment storage
> + *
> + * SRAM:         0x20000000 - 0x20081FFF (520KB)
> + *   U-Boot relocates itself here at runtime
> + *   Stack grows down from top of SRAM
> + */
> +
> +/* Flash geometry */
> +#define CFG_SYS_FLASH_BASE             RP2350_FLASH_XIP_BASE
> +#define CFG_SYS_MAX_FLASH_BANKS                1
> +#define CFG_SYS_MAX_FLASH_SECT         64
> +
> +/* SRAM */
> +#define CFG_SYS_SDRAM_BASE             RP2350_SRAM_BASE
> +#define CFG_SYS_SDRAM_SIZE             RP2350_SRAM_SIZE
> +
> +/*
> + * Stack / Malloc
> + * Stack at top of SRAM, grows downward
> + * Malloc heap immediately below stack
> + */
> +#define CFG_SYS_INIT_SP_ADDR           RP2350_SRAM_TOP
> +
> +#endif /* _RPI_PICO2_H_ */
> --
> 2.43.0
>

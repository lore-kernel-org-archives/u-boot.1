Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D60C88E50
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 12:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5008B80CA2;
	Mon, 14 Sep 2026 12:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeAesdxDdjXo; Mon, 14 Sep 2026 12:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4FA8F80CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789389523;
	b=B2MgPFhJaD31FM1tA2WSfgZU8hoHGRNooprfqG4FClXzlHs4gWHm6Ec5KmfYNUypZq/Z
	 bAk9OI4AqYhTDIjqWOFD7L/Bai5ZYXSsz1TnBVgEUjWqfkPBmcJwsWxND/X+odm8UG59b
	 S9areNYSMLUphUJyZR18LVwTC45gcojGmkg0/xh/vzRohUx7UqyeqsrXqm2qbwaKyeZIr
	 CoXeKWa74aR6UBNPxKoQJfD3qqnohzlsKZtdSaQ49+ieXQ+9kiNx0VWaIGi9iRvZZCxeX
	 KkWTNFjmhbqpmz7u5Mxw9XphcuJ5UaDyBWVpJWHJAMZQuL2Cb4fEtpcUERcMoaHfh0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789389523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wsfSsl7RcKSXF4MBXdpdxPCSGXGrV/xciMYWbGUnx5M=;
	b=b+ao9vyGhrbi7H+gRTHK94FYxbg96UPnYtcFbWQXfthlOloOgXDk9hrktN8xGaYiFkja
	 6YSo7ErdEFWgB/d0VcIKlXRTfK8qdDMLR02ylm6nYpFHGqeDSHAP0p6nxATDautBrguZE
	 yb8VlRYf9r6IUuFvu6toARXjZ9Dy6GiO4k8bnSAAwl9DvmI/h+ZrwCW6A2Hop5NW3N7ij
	 0dXUnmSU2r05GbdOyKXQgOvlDgZF4IGIUYzh+2hYoe5AyOaG8Lu3vhqvCAlxb27qyzuvL
	 3G3v6sKCpOtv0fPGPA8PEDI06CTRq3+ey5wNl5YflDDRvI129bgiic0t3cMiqdyLclw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789389523;
	bh=wsfSsl7RcKSXF4MBXdpdxPCSGXGrV/xciMYWbGUnx5M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HLON+16ybPm58qZk39/vSGJPBYdzxOmOp4hU5TqUj+j1TnxzGvY9ZZEQNZDaIP25a
	 BEDXL/HI8ydmn+kgyNbQq8EwvD1I90XYmbqq+/T+oVtseABRE74F7hVSEY7d6L1oy2
	 VwfeD3ge0BHe+TcaC6xFuco3Hglr0l/bO/C49EU1MMrzqddbdIjgp7WOjN5u5K9G3f
	 mLB+UVhnZnHNrumDq7keSH9kGFDQxoaZGz7GVasgkdLTs7NH6MPIj4AhgeVPWsBiPi
	 Jec/sK8+b6MzrT2+OAOrazijmH286oHNF05Bc8fMsxlvkzLrK8sBbzpBaOmT9TnSct
	 Dg2HWIyDlssWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FA8F80CB6;
	Mon, 14 Sep 2026 12:38:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 12FB5493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 12:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED57F606C1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 12:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ql_sjS_Z-SP for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 12:38:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 21EA5606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789389520;
 b=IO1GX00qIkZNg345q8r09yR0GNnBLryqrReZ/a79YJoFgrr66bPe5WlhJLmt6b0uaeSv
 BuSAvoTuORPKYjDAyiw6mysZYr7kxj3022mCiJHcoObm4r8Vbq01AyHt7pAjwELJhWW2i
 8scyyMQpxBFfRynymwXdI69IwepJ8iVOzfkAvZOyxoOcRIXX10iRnVOyFtMDH31v3S+n4
 tZgvGwaHV5fpbIWT+OMwuLhJcCMfJbsWIoLSRTF9xH5DxH3j/952yWYIc2rHFF31jIQXd
 3Hvb+vgXBEdsUFag4crJkVM624TBdMRTcviiQkkTvH9lY7VClmBazyIlPY7Pg84spPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789389520;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wsfSsl7RcKSXF4MBXdpdxPCSGXGrV/xciMYWbGUnx5M=;
 b=ikqnDIuDoUWrTlu3jBaUzN5wM48DNQ43P/YY0cOnLYb1KrHOsXGsgWoCjLUtJ9UISRfO
 N/z/3brtgsONFuT/x4gCzSq45oft6vlsgFoYhcYcBjX6RakvP7Inc2mjO5xa1zaLBPXFB
 +bCHI7VKFrBJYSkrQL6jyuHYtMqLafw6ucTGM3RTbeRmlZu/Krd8QCL/pZBN7XIFGXEaJ
 AmnDMtmG9Tf5sO9IIs0v6iOtTekOaVRV7oKQcZlBfdRZwSlDRXLuBRJUOOE1s32jSwOTu
 Rnh0oNU0Bys53QNnoMl4cnxM8p6rLZ29Ot+UVakN7Lnaf121DDJWduGfelSeFZUoB3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=P9tPvR7R; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=P9tPvR7R
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21EA5606C4
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 12:38:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623401570;
 Mon, 14 Sep 2026 05:38:33 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB58A3F86F;
 Mon, 14 Sep 2026 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789389517; bh=3o22gBK0dLC3vU7ywvNQmUC/mj25VxAIM3uNTKw8/tg=;
 h=From:Date:Subject:To:Cc:From;
 b=P9tPvR7RpA36nSlVRRcKjMKbQrht0mq9oQg5K3ZCkw4o9KhVWhomRad4/vobP4hwz
 037NgdgAvYWtPHyfHBJ7gzPnBAO6b0BRcFbpVrzuEDyR9IV/jTmFF+TVkXCd2v8zDu
 ukVTYgRU70QGbKbisLpz6J8C7T7jrVuMNbKWD9lc=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 14 Sep 2026 14:38:32 +0200
Subject: [PATCH] efi_loader: fix efi_http_instance free on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260914-crazy-v1-1-89a0177b7531@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3eSixKpKXUtzoxTzZEujRAvDJCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQBjd9mZaQAAAA==
X-Change-ID: 20260914-crazy-972d7c92a81b
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=3o22gBK0dLC3vU7ywvNQmUC/mj25VxAIM3uNTKw8/tg=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqp+rLsBxkZw8WctSTyNpBm6vY5+CZl//7WnIgk
 TbUUGzdzfmJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaqfqywAKCRDLSfhWdqMG
 lEm0B/0Ta/vbVK6DRoDprbv1feKgFC7/ndHxoAl8HR7SrNNUJGERx9PqVZIe0QWcf0wHY3aMBnR
 IqJlXf4Q/7CtO8tNzCRpzCyYo0QGfmgYE7Ddi8lJmLhUlttyUlRx4bmZ04evYSyI8dfjcV2NUul
 U6dSWPnJyNGGLuGEMYEfuVwcXJqe+lJBvzSQJNViadcrg81sjL/a2NSKiympKpo+7I/Uf1aVg22
 uGQrAkSW5rnsBWM1AeKK6fXlG2+EE8OuFZZDcqqc4r6mHRYYR6UMFmFZM56OgapnEFu8uLWgCeX
 GSKnTskB8DE7wlQfhjapUopiemrB+OReuhrUbYkF5+hh4QaI
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The new_instance efi_http_instance structure is allocated with calloc(),
but it is erroneously freed with efi_free_pool() on the error path.

This can be verified on the sandbox by modifying the code to force the
allocation of new_instance->handle to fail, and with the following
command:

  ./u-boot -T -c 'setenv efi_selftest http protocol; bootefi selftest'

This results in the following error message:

  efi_free_pool: illegal free 0x000000001928d470

Fix this by using free() instead.

Fixes: 238e0269d82f ("efi_loader: efi_net: add EFI_HTTP_PROTOCOL")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 2a606aa441e..d26b2119d6f 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -404,7 +404,7 @@ static efi_status_t EFIAPI efi_http_service_binding_create_child(
 
 	new_instance->handle = calloc(1, sizeof(struct efi_object));
 	if (!new_instance->handle) {
-		efi_free_pool((void *)new_instance);
+		free(new_instance);
 		ret = EFI_OUT_OF_RESOURCES;
 		goto failure_to_add_protocol;
 	}

---
base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
change-id: 20260914-crazy-972d7c92a81b

Best regards,
--  
Vincent.


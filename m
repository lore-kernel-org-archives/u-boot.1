Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B06CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AF6E80DAB;
	Wed, 14 Oct 2026 08:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeZEs-Ovhpu9; Wed, 14 Oct 2026 08:42:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AEB980D4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967365;
	b=aJC+HB2LipS+WLA3jLX3LceJb2sIBBDPBXv/OYZ+RGN78AT9mRsaMOYiiwk8EW5GTNoz
	 bYoxTLqQFOluQh0EERHMdcvEJFCRsBA+VytfoKJ0T3STNIaoLflH0uLP6ceg3E6a3Ga7K
	 MLSeS1RFP0iygTVKFfWstEZhR4WcBI4G2YArO2+d6M4+uNk2YAwhS9OdQCysNV9gUoQy7
	 GX06ce5uCipUUrf1WXb/voDIqqaK5SA8/kxRFWfgGkvlnSNx7f/0P11oiVKRZ3UxdGtH2
	 D3yrQJLTfbIBElsS/iw8O+lEIGjbPIB+u6M7gksJRMOyQnMxEmv4u6KqBGbLWD468DQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R16dJnUOUUoEPUC3ow0qFvKudL4uGg2BTghbZHnO+DA=;
	b=eEeg6ECNqK82GHGoQtSt/QXD3Dx2iTyQK87vrSC0jiiABHfdxeBaZncjkXA+EESgrRBI
	 EqJ6/hsbe/74R21mF/LybChXsuYmraSrg7sjtxH7S+IrIt6R5IWQIRTVCrYFv/h+u9Kc9
	 Vb78YP2QBimLP8AuCDrEro+iZay6t3op8jok9fQn0DVAu0csiNZ4TWuDca0uEN5nQpnt1
	 vrm3motChwA8J0ss8zRQ85dU+L0Rfu66w/7xLkoaVbw1X1AiUMP9mDmNycozEXM2dDQC1
	 PNfy8l/C5xGFLhW9/YV4Vjx4Xmt0SZ/f8X5fDoZyUxYnBN8vSsk65hPdO8smhF5qkDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967365;
	bh=R16dJnUOUUoEPUC3ow0qFvKudL4uGg2BTghbZHnO+DA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r/7PoR6l+Tz5x5riuyWa+qeI2RJOb/HY7bShvG2HaCktWua65Dk+zlMY/fBGq80s+
	 j9uU2tlZ2vI704Cx+OglBhu8NQ1Ah8XsySjnd/iLOcWvkqnyDAHdL7rzAzaG4AOuNZ
	 ebk9owZwNayupMTHh2DIye1+YlO7Mxs9cSxiocYU8jarYRtHVoH0ZZyKykxtLBOZHn
	 OnZSa+vkN3HRNMuNVydYNA8FhUdHvdq0iX7VtRmVKPvGOwGGDqoe0z9aUZtTZKI0BR
	 QkRs9vogTtFsbopHctaJCQ4dSmuWTt/CVDUqi6rXE1vzqZUEplo+ku9M2LoPg2Bz0A
	 eKKM0rjPoMHxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AEB980D4A;
	Wed, 14 Oct 2026 08:42:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F9D2255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4510E405E2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PF-1yM3zoY9W for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2063F40606
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967362;
 b=EWqFRew09LTdpyN0Ih7itP/mgtp/+iXEBlBMseITPCkkvLj6IYGPjkhvLymqxAWDVHmy
 qDdKYRH6j9Fx64UTyAtNy2PglppJ1FU0bthj6wmpNnAQ6g986Pztl4WNhXmmm+X75C/GK
 /riZnVGloZ8j2NxUY0IdzSHZcbs9PvEuipWNnw6hXIvKYfQYSiKrfQus9rhFopjHad392
 d0J/+GtyIZUtTRqWfpcQ2EKswDPUgaWW5BJXLMxfnoo4yNKHjXdsTY1qS6nRoREr0GoM+
 8jUXYK+yn4wFaC53SCdVrS8tMZUe2XghM3BWHYTFYELRcPwcY5UYxlImDiGkXXHC8tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967362;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=R16dJnUOUUoEPUC3ow0qFvKudL4uGg2BTghbZHnO+DA=;
 b=kHiUszTB+EzZXgKPODV2rDb3KaFsY9ckWc6KETKZp24r/fEFxrwccop+VNgjll5nBNhh
 b6/FRFHeBUbPCP1CxTJZIKNhOiBNeFGatvfNGTOws3s/JzaCwXR8HeCdsO8CzuShT729E
 +LkPrs6fwCyFdohJEssfgq/CQIrHBCynyEFAwb7JENHkLfFeheMIVvFwUz75/GzEIhTsD
 nXK58EGipPHr5CGKC0Ksag06Doot49haE4z/ugieoOYzzb6LMMr9W4Td7Lcc1Jrbw+d5+
 GsuAnKmoVs22jqpIlct5NQWKCGrMhDSq+NHFKJhaxy3GKXCAJlyQYXAzknJg2WM0Ljg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=WSFw3Mlj; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=WSFw3Mlj
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2063F40606
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:42:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279DB1596;
 Wed, 14 Oct 2026 01:42:36 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.14.60])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9C43F7B4;
 Wed, 14 Oct 2026 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791967359; bh=8QO6fdhaO49kqsXyxlP6RVQaSdJIOP1wiBT+jZl7cY8=;
 h=From:Date:Subject:To:Cc:From;
 b=WSFw3MljroGGNCHK1nMJZnTbgLcv+KgwAvB6WXF+pADbgDb0FuZQLlbjcRrN2079x
 sd1wVRQpN2mj0zKNCNp5rf1kbgndD4UsL3Uq63FLBXkDXn2XD8MYCurzLT8Qp2QGaT
 N7fwbXhF/90nbahKVKcjufzrtqfWcIwFP7gbviqU=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Wed, 14 Oct 2026 10:42:31 +0200
Subject: [PATCH] efi_loader: fix use after free in http
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-deschi-v1-1-1605024b971f@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5AMBCE4VeRPWuibYJ4FXGgBuuAdBGJ9N0Vx
 y/5Z24SeIZQldzkcbLwukToNCE3tcsIxX00mczkOtNW9RA3sSqthYYp4KyhGG8eA1/fUd38lqO
 b4fZ3TSE8kwYkOGoAAAA=
X-Change-ID: 20261013-deschi-833e1e27ec32
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=8QO6fdhaO49kqsXyxlP6RVQaSdJIOP1wiBT+jZl7cY8=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqz0B9duxSJHlUDnnZjZKbf58VZk2Tn1G6Z8QlS
 +WR9IYSk2qJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCas9AfQAKCRDLSfhWdqMG
 lKB1B/98ap+gUpPn2IxqJEndZ3y1GgSLWqN4m75m+4LHJeN+6RAd/gsC9ZaD4sp9GQesxbJh8he
 uB8Wem+Ww+IeOm6cizKskeKKKnUvPasrf/LXw4/5oqC48PPa3wzIKcjuUpXmobMujwj7GDAyY17
 w4mYqd6booManUCjESDMM9Ap3dGddiACeyJy/14RYD3DVUqeKirzxAATzy3bW7ArZLJ/p8yE3QY
 FUfXGPtrnTk3DalHtdinLevZZJ0LNbXx1ur+fx+jmJVvwRtelolJM8YEwAvpXgo9sP37LpwWdph
 yCYhgv1flISUORODqQTwSTjM8qEaT7z0PkEPhs3h2EcKKmM0
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

The efi_http_service_binding_destroy_child() function uses the
efi_handler structure corresponding to the HTTP protocol, and pointed to
by phandler, after it has been freed by the call to efi_delete_handle().

Fix this by initializing the http_instance pointer before the deletion
and by not using phandler anymore after.
This has the nice side effect of making the code freeing http_instance
(arguably) more readable.

This can be verified on the sandbox, even without bridging the network,
with CONFIG_VALGRIND=y and the following command:

  valgrind --suppressions=scripts/u-boot.supp \
  ./u-boot -T -c 'setenv efi_selftest http protocol; bootefi selftest'

We keep the code clearing the http_load_addr pointer in the structure
pointed to by http_instance after freeing the load buffer for the sake of
regularity, even though we will free() it on the next line.

Fixes: 5753dc3f6572 ("efi_loader: Prevent dereference of uninitialised variable")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Hi,

If you prefer I could also remove the (useless but regular) clearing of the
load buffer pointer in http_instance:

   478          http_instance->http_load_addr = NULL;

Just let me know and I will send a v2.

Best regards,
Vincent.
---
 lib/efi_loader/efi_http.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index d26b2119d6f..5c6367a9e53 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -467,15 +467,17 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 		goto out;
 	}
 
+	http_instance = phandler->protocol_interface;
+
+	/* This will free *phandler */
 	ret = efi_delete_handle(child_handle);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	http_instance = phandler->protocol_interface;
 	efi_free_pool(http_instance->http_load_addr);
 	http_instance->http_load_addr = NULL;
 
-	free(phandler->protocol_interface);
+	free(http_instance);
 
 	num_instances--;
 out:

---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
change-id: 20261013-deschi-833e1e27ec32

Best regards,
--  
Vincent.


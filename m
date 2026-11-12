Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BE606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=czpsNSxA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pn3PoojA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2354F8146B;
	Thu, 12 Nov 2026 16:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDRRQK527k0x; Thu, 12 Nov 2026 16:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E15281463
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502545;
	b=D+c5eu3cOwE3spJskS6igAmkQtI1zED9+8NxNmqJ0McUew+q6wgUF3abBprKqOM1oIsH
	 4RAUj7wBuurxweaX8aT9GFZReFC3Yh9cT7PjQCTIWhiaNWIgpaYNJD8vUMRkT80m5BAcY
	 pkF6rIixkLDr2rTdrIqQmdvM0tvVK9W2EELzGlCbmApKFW+aGuxBKIcaefJmdQ95v1X22
	 g0XMwWw1RwhGuqWZ7LBU+LDV0dyE+FSK+xow6PyNWgYx8rywXTSa+rbhAUA3mPS+TfOdp
	 9HwW8XxUCPPc9Ju/7J8LCpb57YAa/bKJa6+aNDr0lX/jmpIEYQymHtdt+nWOfSy6qog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y6bda71CRmSOT9qf07K+k3pz0Ku0o/5KLXSAuGjfjt0=;
	b=M99cH3dgRZ4aKJSkFMCnv1gyTioV9libQwKRnSSHyBaKl46tqzHGGlxgRf0oS214dg/W
	 5tN/BH/1Jlphh4e9pVFRDniSXBq74LXFcchfrgr+9az5mDnd/0dRaEukT4YyzdSfYeb6S
	 d9JRswn9nKMG2espT11Ns8bFUVkaVMc/H/VdJGaew7XJIOQI9dJnKl2wlLUQs8MqYW45X
	 e1XucJ/xQ6VjGWfzq1NvoaMlSPsq2Zw/V0an2isijXcQwAhmNrE/EkwNEuuN3qEaQFp8o
	 4e2Od6YV3/2fHex44fp5rIw7txQ3xt7jwPkV3grjmmgClhNy/6c8gNpPYK51zFyd1Gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794502545;
	bh=y6bda71CRmSOT9qf07K+k3pz0Ku0o/5KLXSAuGjfjt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czpsNSxAOBbnMQ3RN6adL51r4Zu2oAy/Tak+WN2Eqg7JrFywsP3eYZgsunmKOwle1
	 kFfnAvAubum57qvp6zf39KzN2lKDwltlpgU2SdyR0Sgbg94JAD1gYo3gVxPMqWC9cU
	 c58NndsbF1Tk+eaFCCNNpQ2KIDcVZ0evbVyJ5wZFyqJ+SqFxGBQM7TJbDwCTNj0yx3
	 oQen/U2v0d9ilb8vTmGhMJfojKXEJjtvvH4Zyx04qzOAIYKO6M0y0zDJhx6stBk7s6
	 rFn2k+UnzHxbBskZfM1IForCa/xK5ZtMdkkckPa/h3ov2qt3TGWWlgqxdFWzP2HanV
	 KAuV8KztZ9nJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E15281463;
	Thu, 12 Nov 2026 16:55:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE2DC2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B019D40AE7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJH9YXrjsyN3 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7603540AB1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=pn3PoojA
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7603540AB1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5ED5153B;
 Thu, 12 Nov 2026 08:55:36 -0800 (PST)
Received: from [127.0.1.1] (unknown [10.57.16.216])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5C173F673;
 Thu, 12 Nov 2026 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794502539; bh=v+2bbLNRekP07rL8JE7rkJZa/F9HgvpqhOeQOfpx7p0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pn3PoojAJvWM8X+VHfarcDRyHnuSWF93LWitj9WjATg+PtNpFnJJNnm1hrL+0AHJh
 +Qzg3m0a7BbGPpxUuBe6yAq9oz57W1Uv0VdoVl4uqpjAR0nuVIjd2saLIijfy+qV6y
 az5nDa9NjCj2rOf0v19RfrPhC2qWWxwZYMTiksqk=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Thu, 12 Nov 2026 17:55:33 +0100
Subject: [PATCH 1/2] efi_loader: fix getinfo() returned buffer size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-getinfo-v1-1-b7eb8c837985@arm.com>
References: <20261112-getinfo-v1-0-b7eb8c837985@arm.com>
In-Reply-To: <20261112-getinfo-v1-0-b7eb8c837985@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=v+2bbLNRekP07rL8JE7rkJZa/F9HgvpqhOeQOfpx7p0=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq9e+IbQTEUGNriqDnTq7IkQKBVXxbV0lvabuzM
 OKP/oBFaMGJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCavXviAAKCRDLSfhWdqMG
 lJuNB/4ou5P7PCiHjKJeujFqgDExizVhtwK83eiAtfK5OEoBFHn5Tld3dhiD9fwlZ/Le/5QQH4v
 pnmLxW71nzQXHy5mN4ny1ksXHZALsxYCcsS3fC3ER2t5iTOE+6dxsfs03R+PjnMIFFxcaqt83u3
 gq7aS/qZKVjjttR91XgHb+ezAS73zy/o8v2VDWOe49yDZWEM9D9JWZPL27ddA5Bht+sBqt9OE+r
 L6BobCyU8UpZ3mNA5ev9EImPp00JuOYmZepX7ZzQ76m6CQwp9HHVpAzghPNc9nSmo5uvKziJNCi
 agl8Clo36ZRxhv02o0gd9zX/OPSSvyCweXmKwVrZ188cxhdP
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The EFI_FILE_PROTOCOL.GetInfo() function must update the buffer size, but
it does so only when the buffer is too small.
Update the buffer size on the return path to fix this.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 7dee57d594a..d44aa5eab7f 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -846,6 +846,7 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 	struct file_handle *fh = to_fh(file);
 	efi_status_t ret = EFI_SUCCESS;
 	u16 *dst;
+	efi_uintn_t required_size = 0;
 
 	EFI_ENTRY("%p, %pUs, %p, %p", file, info_type, buffer_size, buffer);
 
@@ -858,14 +859,12 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 	if (!guidcmp(info_type, &efi_file_info_guid)) {
 		struct efi_file_info *info = buffer;
 		char *filename = basename(fh);
-		unsigned int required_size;
 		loff_t file_size;
 
 		/* check buffer size: */
 		required_size = sizeof(*info) +
 				2 * (utf8_utf16_strlen(filename) + 1);
 		if (*buffer_size < required_size) {
-			*buffer_size = required_size;
 			ret = EFI_BUFFER_TOO_SMALL;
 			goto error;
 		}
@@ -896,7 +895,6 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 	} else if (!guidcmp(info_type, &efi_file_system_info_guid)) {
 		struct efi_file_system_info *info = buffer;
 		struct disk_partition part;
-		efi_uintn_t required_size;
 		int r;
 
 		if (fh->fs->part >= 1)
@@ -909,7 +907,6 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 		}
 		required_size = sizeof(*info) + 2;
 		if (*buffer_size < required_size) {
-			*buffer_size = required_size;
 			ret = EFI_BUFFER_TOO_SMALL;
 			goto error;
 		}
@@ -933,8 +930,8 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 		 */
 		info->volume_label[0] = 0;
 	} else if (!guidcmp(info_type, &efi_system_volume_label_id)) {
-		if (*buffer_size < 2) {
-			*buffer_size = 2;
+		required_size = 2;
+		if (*buffer_size < required_size) {
 			ret = EFI_BUFFER_TOO_SMALL;
 			goto error;
 		}
@@ -944,6 +941,8 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 	}
 
 error:
+	if (buffer_size && required_size)
+		*buffer_size = required_size;
 	return EFI_EXIT(ret);
 }
 

-- 
2.53.0


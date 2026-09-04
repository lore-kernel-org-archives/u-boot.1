Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B3BC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCD2480F6A;
	Fri,  4 Sep 2026 07:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kd4f4d-IOXR9; Fri,  4 Sep 2026 07:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 284A180DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505980;
	b=oaDfVevhrL6GpjD6hAvXquh7WwZhyzDdBLp9mzKhQLKM60U2zgfPXkFFbtcp4tuTGl91
	 Kw55hZ5YAdpx19f9R9f6Kh5juvFLlT+D4hDY6z+mCfRxlv3PEt1Oz4xdTLX/fqhY/XjWp
	 De/pb09Qj4e2PrDWQgUgp+CFcY7I48H0E3WglG+/Kx299udkgQFzbsUCgOd0XvHIMun07
	 aygMAcvTm3zm/9FXfptYBggepjj9WEoTxGP4aeV/UtWwaGPfgd1SFdccWB5e1tR9m4+w/
	 RYA0vYblIP0eODqD3Omz8LCWx7x/nTfvOBIoZj6s+LUiFsYmH09rAPYWzyWgo5Yknzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z/J0bpMRwYcbsaNNzfnLrfzPHX/HBdDUtuDzzCTRCIw=;
	b=lW3nZW9LoBLXpwTOkF6utMmYXtgiyil3iVj0jYO6wcd4ATCPx+kkP4FQnS206safOAhX
	 5cIzPNzPV4skJYRjTlbwHmyLuzutydIcTK684J8uH7HCC0rIrIEn8iNT5y0hxeEBB2BE8
	 91SYVLPp7RcUrC+NDF+AUve0wzn8GGc1wgzGheWZzqPcrGe1S4FiiyzQuKOhNgQfLvYgO
	 VzImSKUoYL9C9qJ/RwinpwAO40zC3KsOkEDHipmAFd5ueXRH/N0h93qtUwBVbaqmsEovv
	 BKt/la4nfDHPw1jYmUT0ARaxZupfcvEZuNecWljkqKhvH8HjA1Xk1dN8DbI+TFzsgJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505980;
	bh=Z/J0bpMRwYcbsaNNzfnLrfzPHX/HBdDUtuDzzCTRCIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NV+b1wHlVk6gE+9YlwSThgWtta8easPQMPH/L3QLKtGzNWfvcuyQkqUl2VSIOW/Ni
	 gagXhgRZcALMZq/GZLfQFAUkivXectk6nsGr93h4nqYDV8B2RKbdgR/sS0ueZBOM4U
	 FOPq5wr5w6jo7QKqD3sA4sYJ8ruR5riUdB6gsw2Y05aR8pRtXaisfdhJXB/FFBsJiE
	 xVOmkBSZjj5l6FbtMRoHfdxXWYpdpBY4oMiCtHiTOUTs4xhYsp+LK+9QafokfpBctZ
	 yNZrVAboNaUY9o1WPVEB+I2tzJSkWBhwGdkRtpEAi8+4ULKq14gnibFLjhFQ5mt3aA
	 TnKyid5pcFTUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 284A180DC5;
	Fri,  4 Sep 2026 07:13:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28CE32FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26DA84008A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4UkWlAJYN0Lu for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3CD8540080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505977;
 b=EDzcgJmUYrCgFpFNumze7G3WDwh0b5jbEM/WNo06uUf55MYk4OTi5/qpbDfQ/txNB0Dq
 ZYbWuakqUuSCiShwdl/3gCVAvL4aTUyrUqBqO/JZZHiHGjInkQpqg3V+O3pvfND+H8DzM
 cymY72RZXiYr5FU1xqVkRrTt3lGj+1747wcW7gjrNQzlX4U0DKOZW6vsURnKi8pYyQQve
 HkIVN4Nyv2nwh+7doVVJwaJ8jvyzODnZloYMMprpawkJ/jnEApduuvgFsj+2vzMy4pwRF
 WWa7u/ODcxNZLbhFxNyWGb/gbDhoJtV1Mbtb3jtiVBSgCktvyHur6+subzM5X9zmF0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Z/J0bpMRwYcbsaNNzfnLrfzPHX/HBdDUtuDzzCTRCIw=;
 b=JZU+r4U/Po7YPC7Epjh1J26lGJkWtwv948yD+53ChIc0v8JCQOs1ThD0DgXfrAyCYR0i
 AofPwXCMdl0Y5xCDaPIo2K0iywqJtYBFhvFK9QkQVZHJIsJ1USnwN8EwT5Z9tgddoTg4W
 vUUyUCv8sZf/n7v23yu28udI/GoyLRiJp/zReEY9y9NwjSYRRRiZq1KAikx9l+9XAGDFC
 IHFutFP3J7oXH5gmaTYVtnu2fHhXBQNg7tQTPzSIL6VUTb+OjUZZvlUI/I/O7SnKJYY0t
 /WLWDmL683f9DOivsABfK9yv7bWOR5HJ2A2aSV0onj4k2X7r31bKZegI6RSlK1sfBrw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="j1fOz/VL"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=j1fOz/VL
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CD8540080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:56 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4858595f997so403105f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505974; x=1789110774;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/J0bpMRwYcbsaNNzfnLrfzPHX/HBdDUtuDzzCTRCIw=;
 b=j1fOz/VLp1PsGwI/MoRjCY85jo9E4byi6mwCE5nqAiyrp2ruRUBg0ni5CxzYKO7o5O
 uJ/AjkXDXDnCBt5fjUx/LDPZ3KZNOMH10Sqm9Pqxq/GD+ohRBQWZTbLoV6NE1XvX4G2L
 pP/z5dsLSWUQfgValFY/B1azwisyoi9cX+kMKkc8gVqL4SrQwNqcZ0lqBhkMI+a8MXgi
 /7uhUPOLz2BCR8PBcIpm7irWlh7wo0Cmd6/QONETCOS1d2Xl8Z4ufHDP7NIe/9p+buxB
 7mYmavSuvXeSOVtu1yV4gd6rt1e0NcFa6y4exS+pm6Qn1q6SqCHCcrrjYv6kufOJpqcJ
 DCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505974; x=1789110774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/J0bpMRwYcbsaNNzfnLrfzPHX/HBdDUtuDzzCTRCIw=;
 b=kesFEL9qFufYqMQbGwmgxRpI8RGBgi3MLNutZHAnKyZxp+6aVN6dIlbaNQzCZfserk
 n3Q7/VTF2gnlQruJANhhTdqoAiiBVcAtROvhpFH2+6wdUZBEPUZe/uPeGJZNI4k/6qLK
 a+PfkSxRRoh+fMmUocjvJ8KvTV3XeQ5TWwIJ3ijvV1QF5XSS/8I739qZqfepPbX5UEyD
 JEuXpkxoxTxpQdZr8C2rMQDZCEcl/Ngx3Anu12zWrPWIoigsxEiexpyTcjz58w9ZGvvF
 sPoMyLhfNLiMEooajaUDHVUeBRyMJS16G1H9x8zo00JcrGAhUZAAHXkDQp94HB7WfOhH
 EPJg==
X-Gm-Message-State: AFuF++noCXv12zn1j5TfKvNeBhUyhyAL2QiQo0aiPcx9nGmYQpk05wDh
 nB4khATic3bK9vwCC4uJd79bw+MEcId/Mn0SqVk8J1quLmsljS8H+Dp8UZAGUSu6X/U=
X-Gm-Gg: AYBFou36UANhVc4olSDmdE4POgXcJSAdPlr2R8evHz4lbZgXnT9MQOVrXyy+GpJj2u7
 MMNjSvYth24SfI57wuQEy+OZAWT2cByPNsdDuYaVeLtCG1kA8onbc/d63fnBqFzdHhFn9Lw4l1D
 r5QufzSaQb3t9UrQHvYbRJJ3X+Uw2BaxX5ZILkqi9edcZT3R8XTqdY2OccHd87lKAPXJmrTDUVZ
 iAAK3iMmkvsxeHBq5keMV+LbzDGYATDVB0h8IKOw5C+yCoRQJsUuHypxmmzIvqu0qDFDXDElSGK
 dGR8KKdGC21ENDJMQy3TDVgcAxhSGtwaRzIKJwNwwGEb1v9vUH4GK54pRcSeLYuv4ILG/7m1qXL
 Q6rCLDe29zD3WF4MoEwa0oiuGoTn0thX8oJagcM/cylwhuLEuYy10xmI7Kr4DNGq8s5XYDs4KCC
 eywPEcmJgRnXqbhQrQ1/tDa1Z6KxsSqNesXzlgvjO4Wr1VIC5izhUR19CzurdU86mjR0zlCRXtq
 yFq3Xv/sncWDp4Dm4GB2InrVIVqiFlTw6rs7l70
X-Received: by 2002:adf:e19e:0:b0:482:dac8:cd0d with SMTP id
 ffacd0b85a97d-48587288cddmr8819465f8f.21.1788505974037; 
 Fri, 04 Sep 2026 00:12:54 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:12:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:36 +0400
Subject: [PATCH 01/10] ufs: hand sense data to the SCSI layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-1-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=alchark@flipper.net;
 h=from:subject:message-id; bh=lpLhJysI2Gb1jBv5fs/QHGJYxVznEBnIbWV/tbnjSSg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi+cfc9wrt+MhU0iaY/m/pxp1usiLTStlVGWbZ57k
 573uZNOHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1pouMDL/rjFeueHXh6LKgHdxJRX7SMnIr7slPbejforlB5Pr8t/yMDHN3v6p
 P8eVR3W+cmCYeVOkUqPHCIT9y1qqZqrmsPB0bGAE=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

A logical unit explains a CHECK CONDITION through its sense data, and
without it a caller cannot tell a transient condition from a permanent
one. struct scsi_cmd has carried a sense buffer all along that no driver
ever filled, so fill it, and clear the length in scsi_exec() so that one
command cannot be read as another's sense.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c |  3 +++
 drivers/ufs/ufs-uclass.c   | 23 ++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d45..54afac6eaf51 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -22,6 +22,9 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 	if (!ops->exec)
 		return -ENOSYS;
 
+	/* Whatever a previous command left behind is not this command's sense */
+	pccb->sensedatalen = 0;
+
 	return ops->exec(dev, pccb);
 }
 
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6ef01f8e4aa7..acaecfa1e341 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1657,6 +1657,24 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
+/**
+ * ufshcd_copy_sense_data - hand the response sense data to the SCSI layer
+ *
+ * A logical unit explains a CHECK CONDITION through its sense data, which the
+ * caller needs to tell a transient condition from a permanent one.
+ */
+static void ufshcd_copy_sense_data(struct ufs_hba *hba, struct scsi_cmd *pccb)
+{
+	struct utp_upiu_rsp *rsp = hba->ucd_rsp_ptr;
+	u16 len = be16_to_cpu(rsp->sr.sense_data_len);
+
+	len = min_t(u16, len, RESPONSE_UPIU_SENSE_DATA_LENGTH);
+	len = min_t(u16, len, sizeof(pccb->sense_buf));
+
+	memcpy(pccb->sense_buf, rsp->sr.sense_data, len);
+	pccb->sensedatalen = len;
+}
+
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
@@ -1683,8 +1701,11 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
 
 			scsi_status = result & MASK_SCSI_STATUS;
-			if (scsi_status)
+			if (scsi_status) {
+				ufshcd_copy_sense_data(hba, pccb);
+				pccb->status = scsi_status;
 				return -EINVAL;
+			}
 
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:

-- 
2.54.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B603606A327
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HY5sMraV;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=kqyqcs1j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6ABD40735;
	Thu, 29 Oct 2026 10:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emjQ5yO-p4cz; Thu, 29 Oct 2026 10:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0950C40775
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268311;
	b=kTXkzjwzNjzfgT+YMrd4XKVTmZHSh5COnkce9pVHq+/3mathDCbIzujIBEFyJocGKLad
	 U/v8uV9yaorHJRRQyUY7Css2AxuTl4Rt/w5zWmvSRGZ2U4L0nj0M53mtfUNxeQW4QVrsu
	 QnckjICJUdd2hBodGoMSly+1LSWVLBbVz/nUuL6HnqlgKXGckl5pM1AvLO49hosLKm/pG
	 qAjoKj63YP+MLAvGTfwkJzmAJUx0N4j9dT7E1b+vY9B1p57aI9WpHijfbIQiEC/Opll/q
	 lymC49LU7cChUSFKPMxcc6da7JmRYxFabc1vSSppgKzE2GcU4mAMhLkjC4WyIjS6Svw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	b=lqwkSf5ysnS0Se2bemi4xPgX8sh+HwRSuubuH5/irfhIJHPaNP6nLlWEnYRQiJuPe10P
	 HrkTOj+wWLOVKWaZOchKhINz/yLXci+m9bz5G7wRnWAqI47jnDoXggsY1gKqfFjZ5ir9d
	 uNRFU8wXx3OV4O2bmCyqFcxpiDrjmA+TUqUtQJdPbjH5/rVP94THThekORoffbOEvnVxh
	 W7Gb1ujHPNUB0ZhkmsuVsTmyHWwmMiB7V58Wn6op4bzzkwbUnqVzZEX2UTmvH0XV7vVRW
	 /ctfKJmHVeDSGctlDjoQfKHng5lubJd8xK9cfvrkSGEzFpL93c4qOdom+GObz9BACsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268311;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HY5sMraV0vYNrQ8G59WSGTbnKMw2ixsITuR3AXLh6CK7IUhDHhk5SZSPxADzR6EIA
	 kOUNy3WkWv3SNf75zwBZdhkKCy8RNfKCMWtJo9jaoKh8e2lfYHJJZrvU0jBDC86X7d
	 cJL7JL8YMyvbRBC1nYqVUoXSptvIqUzhMG0BlGr7VkFvuDoS75m+VmCJwPci8w0W+P
	 FKiJcOrVHpwz9EXylC7E9nhPBdrNLhhVTZZdIMGASM7Dfc3EufidpVEOiv0015Jpax
	 nW8zsszokWGc5fryt9Z8xfAi++KpbywbXd1koye5DDSmxWw1uODVQgMgb8PphpUXT/
	 zYG2Bugoo0Kaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0950C40775;
	Thu, 29 Oct 2026 10:05:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA9C4380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC8EA60677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldY0YNrUJcB7 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB69A6069F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268306;
 b=Hx+HymmFKrz8HP672PjqeW2NcNKKbdnce86DiG1Wgpyn5zuZl4vDD7bR4KNBtkQudprr
 7XwaifOelXFV8ysqeiO/Lw/93BHpVydvHb+AjvQUKWJWNPwQ50PvYB3cQdY6O+rLV2hkb
 1YOMFPiornyHMOT/7r4Q6QmEGyhDF72qP+70HfBKzMsgLKZKJh+SbQLLK/hrWhmc8B4hK
 H7QZlUy3VPZNynoHkoE1gVLYjQ8QapMjv8EuKT4eL6eel2m3PAow8c/xeMRMFHWHyBfEp
 8HmF1sEA+wbZRQdkYpRWSkRykLrA4QhUrzt00xfKqzTqjXkBnjcoqHCRFOjcdu9z3hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=GUStbSou6PNXFWYo646oxYx55fHuzyh/FcK1IKmbzAcIOVRRfnM5mxaisrQUnRK3wiWk
 gIL6FisUdJ1ArMehT+5pmQoWTYsD/U0HQWDvl62DHbdrMlaH57fGXVmzHDwGYj6POPDZJ
 TfmburKDWWXRBqUWmnQ3XHVKk9nbJGEAOkBpYM1FAoGxStx8/wRRopjer58IHEF8VSCTD
 ibHW4Z+HR5QWv5K3+wzXaGId1dfQ1Wd71L/34ru7DgVx3Zo35DNWwODXrOurEGxjUAlS1
 x73rc+JnXBOY/zIGqQOEtFvZ4q+Hjrx++kGpc1Ian9/IQfd1dl5BtTwZhgAUFnqa/2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kqyqcs1j; 
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100459b8e59d98b3000207fa-ygeujt@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kqyqcs1j
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB69A6069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:04 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20261029100459b8e59d98b3000207fa
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=kqyqcs1j81lW7jDunz+9t+qtizxzeQba37hZu59kou3uE2DDRTivREwmp9hegxF4NuLkJj
 ZiKc7hg0jf4EW5ZhgPkxSWpLLjMpb6lWyyFM0LbgmBadom/MyRaVKTFuM4uapEzfesY8S4Fe
 VUIv2BMumJVxNpDdVBWevSYPiBlzxkUmHWMB7o9YQ+l+Ps7UZxQNlcElVeA87AJWJBFP99lr
 9VbDERDDMAo3Q5PWEFc4+oN9vT92qYJje6ZPzTTG1f8VF1lG/tqAn1HTSPkdr6fTs+vOnUmg
 dx8ODhR0X5Bgka0R24kZtBTgS3cQy/IEbWRfyVHIT7dRjFlquuEs2vcw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 1/6] mkimage: define log_err and log_info
Date: Thu, 29 Oct 2026 11:03:52 +0100
Message-ID: <20261029110356.v11.1.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define log_err and log_info centrally in mkimage.h so any file used in
this context benefits from it.

This patch is in preparation for a change in image-fit-sig.c in the
next patch.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v4)

Changes in v4:
- fix and reword comment

Changes in v3:
- make log_err use stdout too

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..cd319ddb777 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -35,9 +35,6 @@ ulong image_load_offset;
  */
 static struct image_sig_info *host_info;
 
-#define log_info(fmt, args...)	printf(fmt, ##args)
-#define log_err(fmt, args...)	printf(fmt, ##args)
-
 void image_pre_load_sig_set_info(struct image_sig_info *info)
 {
 	host_info = info;
diff --git a/tools/mkimage.h b/tools/mkimage.h
index 5d6bcc9301a..d8d292a8098 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,12 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+/*
+ * Use stdout rather than stderr so error messages stay
+ * interleaved with normal output in the order produced.
+ */
+#define log_err(fmt, args...)	printf(fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0


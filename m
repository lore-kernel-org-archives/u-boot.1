Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C8606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IVd8FVuL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyG/FEUJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 859D1606D3;
	Thu, 29 Oct 2026 16:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsB_enu2Y_T3; Thu, 29 Oct 2026 16:32:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7DB960709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291564;
	b=SSNsKnYbbZqqoCwYeMeneL9rHfmNJVq11x8c1352kTtr/nsosUZdxBJOtG0f7AdluOfa
	 L5vxgnJsBj0OldU8GWVBxEEDP89Q79/zMGLy9yWdC11AQDAnvpgEms22IjMiZnB+PSjI4
	 C5OIfOrzSKtb59wSDxm6ZensGs8msP7GCvnYwu2c1T8Jf+apbmeJTvxLRO97Q9O1dmJoJ
	 DSUuf8+EJLEV1aQDkfcSppyGFe0bkw4K2poMrQ5cO+TNdNv0/GwTaZ+ksdYSxk+vszfu7
	 ZbvErIay4Og15h4529E+XGJvVhnBoIRjfmOLmp30bqeJ92wfjEpUGTMpmYfqJLXNKNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LISGfl78sjqxUWSdk1kpgWMh4lO+ik5IC4jVk5yiPao=;
	b=aqb3Y/6axl0ts/9ZwrBMv3OiNnDXEHq0PxMfqtlI9bGJclYp9kdmXRXt5mRrdFERyfwY
	 3vZQcK9QkFb1rnsAoADKA3i7pcYXBjQzaJZBOWLw45kZgymi5Tgi1QzgKaXITTTwCjd5y
	 1+QBOZgajsC+pQ6qQWaC/CCJt0k58kgty5NtlBD8rWhpIycg8482mqWj2SHYC+d+dinZU
	 Gqn3A4LtjHSYOPJA/XN3bF1Bw4ET5UiM0fvOC1Av+tbO97vwtfpwijoVhryZBT4HoFC1S
	 DsSyEdQe1rBE4YVlarDis79apab6cXIOVsTI+84JjDUSwuJfMD3MEELoumre1S9FRCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291564;
	bh=LISGfl78sjqxUWSdk1kpgWMh4lO+ik5IC4jVk5yiPao=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IVd8FVuLyb+Ioh3Jg/0+uIWUKy6p4tFYJAuGVaUbqOTiPhiGiUMkPPB6iC9Q3/rvy
	 8Zj16Pd/I6PtdeCj/Vudf2x5t/DxSAmMbvPfibPrjzM7bZpMDG+Ck+icwQcHLeUVHH
	 BnjCrR72QcFtJ08iC2KvVK2pBpbmP8UkxkX+5vOlkoHEl7DA0i4xdx9ZP0m8VeE0MB
	 Bx3UrqYpvSYB8ubeWKy/D9zmeM76yGQIOSLpCZUX8DzPotgazlDTHJsOd9WICc/qHN
	 uFFxl8HULfr5uL7C8X17ADN06PpnLBSIO9uhwBHbZpxCKkN37SYyrPkM72qSRQay/n
	 Jd33YzCrjYUjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7DB960709;
	Thu, 29 Oct 2026 16:32:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4EEE120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B27FD406FC
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQ363vVwF33u for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD1C3406E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793288544;
 b=POhiZrgEXDTDAHBTsi6v+jrCAXRQeNNYOSoBWqqcZF5FXRyZMuhyEQqsdrSrQ6/Xmn8x
 2ilRYNd8PxF6kOT2LvbWfvHG5Own9Gh5KGSF7v5rqEFtubk69yqRM8qtH7YhqScKGuo4H
 4A3pJEB1oNNdvWpm4f/+T5qokQsOCPPUh1ey9Bdj7EK0ens3viVkyd+gsEzqEAfJt0ynj
 esDTht9+FkQNFi7EqH98oFU4QvZEUT7T2cX3eXmVj2gYoxKwAME1mVag613K7kxHiQ9hb
 wjwjWyibiBA6C8uLaYFGOH1Z/iQgCO4CK5bgoJW2+LiXcYiKtAOtq7frjngmaOWiO+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793288544;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=LISGfl78sjqxUWSdk1kpgWMh4lO+ik5IC4jVk5yiPao=;
 b=bhIFmuBN39j/l3z+bvBmXoH7wMdLKqAMswwGsA8JAz9PIGCZbwRJvOVSdS8iz+XmOWtU
 dixIZGPImC9ffNm3cdjspXGzB3iTQjIcuTZ3foQOeeFBGjLFW2iYvXRIr1LxosacybGcA
 PBTQRzlTx4bEz5mfFfwDIWsJj4eFK8gHGJMdCH4Y30LayEBv94KV9T2kqOsWbnGbtn16f
 nbLBApB49WNc33uFGcSOxcpWjdYJt+rUDQUx5YOPiUNbmXZwFhfsOs/Uj8HjeIwWaoZ1y
 hDnbMMnBZMP9acxXYR6ON/WDXxZy3LILeRE9MeUkuLFFR/XlfugR1g3EYFKO512H5nA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="YyG/FEUJ"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=odeschamps.mail@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YyG/FEUJ
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD1C3406E3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:42:22 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so8495015e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793288540; x=1793893340;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LISGfl78sjqxUWSdk1kpgWMh4lO+ik5IC4jVk5yiPao=;
 b=YyG/FEUJIQ4EugZochgR+MQUFCRthfWqyryLLWLS4I8gLi5NmIFQ66iaVvZzBvxuL6
 XnogbtFTSE7x3E9Iru4OT5bIbEEK2pVKchZPflef9Jnf7Ve5qv2Geepvg4eIUhvVZCbk
 j/VChqi8iDRLI9YCaOQx9dM8UsCbOQQWBgIlo7JuVZdnJFDTvnM10KxPGc4glojCxt+D
 /VjMauTLCeTXj5SSQ4KevLwvn3qWivUE52zNQQyoWbQKNH+aF5OlPhOIhyOWafQnCNUl
 z4XwOwR46Xm6aUkuW5oJ2ClSmo2EWBZ6Xo66VF5YNY3DMhYHTsIxKA/gycN5V2XrE8BQ
 X/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288540; x=1793893340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LISGfl78sjqxUWSdk1kpgWMh4lO+ik5IC4jVk5yiPao=;
 b=Efm+eHM6FA3ir3JhTxFDyj6+lu0WY1u+9t9yj9l1QJ68qUaaXroH0xRBFjCNR7dAG6
 5iGDiSrPhTKy2TgCX0b1sT+i3aMesgcnC8Ak9pYgiDmGxSSNUftwnrOrW1wqbaP8+whD
 Uv1oFbOk8dUlwcO0tjRrSGA9uxUa5kd24XsnJCrJpga0+Y94tNnV24s80dqU//kTBZPs
 IT5I7RnNbAhXml9YWFMUAWazgGFt8ZbCtQusvRJ7TmOUY6htt8U9KFVDJZufdk7y18K+
 wl94UeriWziL1TKtyxP3b5bkF7na0y/T+h4so1LphkEIj59P6Tsh/pw2X6gHD2wvE2aT
 dCpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdHNO0MmLrG2AwneGvf4glXxoFK2jJJls1ZIDGFPNMw88N/a6qaFEh3HdIcRWjgzuuQFUbO5w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK72UiLzfkZ6bE+7ajY0W14peJBDDpyNLqy4yV6VS14Y7PHLkDS
 /IO1qBi9LV0cP7ArrhlYNVdhs2Ppn8mBE3RBwjQGw/JLtvhGqNfjZCDj
X-Gm-Gg: AYBFou2w6WFDlyBFEYCPhTNdDVeNRAJdrsNSej0T6fE5ByQ7jnfIipc6/TETi5m8Wlq
 Mq/eBWUvvUufr3ciTYziaJgh+7xL8R0Hokj1XRMiUXX3LbRsFGwfCbXCjvn85v21NCvoVAjkcvV
 QfIOybT9BY265s9F4cHpOy0/U5ofr74Jx2W9g4u2l/KEz9EKRrclCOPooP2QhiYIDq7fMr372Vg
 cFfckCrWSE+QkJ4NG/xh6iHyl452DJKM2BTAJN8sA7NOcgJCum83p76NBK9fSWax05zj0QXMy2G
 D6BQ7L//ogDygGg/oXiOxpdIRchSYvrKhNrJJCZ+lnLVw2FO45CrP4K7i9GOyfN2FL/EB43iRSw
 bqB1XziSIM49Q6OzrVVSUM507tF4MJgozDipvCKsCJ3QwTj4LRR++i5sWpKJci3WPBm4KrRmywc
 w/n9XWiZszQc9uDc78E01ngMXLbQw/KpG3Byw8e/LXL6N3yGFrXPp5IctwKiGrBRRboQSPBqFP2
 WGqajvLjNP3LbpkTtzBfFL0QU9gxYKBW7rDnsnLVkuzYitNl+J+dbtr3LHj/Ha8vdBjdkfyGh3f
 Dr13iX/oH6LBx63vyapaDWuKmV6c6c79KUOlfGpItfcQThoSHx0z3eTlBscAqYXob8c1y2Q=
X-Received: by 2002:a05:600c:4e55:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4aa876b951cmr73165445e9.9.1793288540086; 
 Thu, 29 Oct 2026 08:42:20 -0700 (PDT)
Received: from test-Standard-PC-i440FX-PIIX-1996..
 ([2a01:e0a:ee9:fa60:a398:1050:1f4e:4ca3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm83197485e9.2.2026.10.29.08.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:42:19 -0700 (PDT)
From: Oscar Deschamps <odeschamps.mail@gmail.com>
To: joaomarcos.costa@bootlin.com,
	richard.genoud@bootlin.com
Cc: miquel.raynal@bootlin.com, trini@konsulko.com,
 thomas.petazzoni@bootlin.com, u-boot@lists.u-boot-project.org,
 Oscar Deschamps <odeschamps.mail@gmail.com>
Subject: [PATCH] fs/squashfs: fix NULL dereference on empty-directory lookup
Date: Thu, 29 Oct 2026 16:39:40 +0100
Message-ID: <20261029153940.461197-1-odeschamps.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 16:32:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The three directory-search loops in sqfs.c use the local `ret` to tell
whether the requested name was found. When the loop runs zero times
`ret` keeps the 0 left by the preceding sqfs_opendir_nest(),
so the "not found" check is skipped and the NULL dirs->entry
is dereferenced (dirs->entry->inode_offset). A crafted or corrupted image
can thus crash U-Boot (a NULL read) while resolving,
reading or sizing a path.

Treat a loop that produced no entry as "not found" in sqfs_search_dir(),
sqfs_read_nest() and sqfs_size_nest(). Found by fuzzing the SquashFS
parser.

Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>
---
 fs/squashfs/sqfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0ea6dcaba1a..c8d2ade83e4 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -581,7 +581,7 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 			dirs->entry = NULL;
 		}
 
-		if (ret) {
+		if (ret || !dirs->entry) {
 			printf("** Cannot find directory. **\n");
 			ret = -EINVAL;
 			goto out;
@@ -1501,7 +1501,7 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		dirs->entry = NULL;
 	}
 
-	if (ret) {
+	if (ret || !dirs->entry) {
 		printf("File not found.\n");
 		*actread = 0;
 		ret = -ENOENT;
@@ -1803,7 +1803,7 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 		dirs->entry = NULL;
 	}
 
-	if (ret) {
+	if (ret || !dirs->entry) {
 		printf("File not found.\n");
 		*size = 0;
 		ret = -EINVAL;
-- 
2.43.0


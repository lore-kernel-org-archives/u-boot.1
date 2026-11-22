Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75153606A333
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WHzzlHRr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLbgJxAh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F47B80E12;
	Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWRioXTBYXbN; Sun, 22 Nov 2026 02:34:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A8FE180B08
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314881;
	b=Zdi7MInzZ5PcZ86KYm2y9OCWy1IgLdzjPJxOZP60+FmZ8FadcJR/TL55W7gPh2FsNXnc
	 HVZMel4Oc4ngYXe+cchb2pcXhyDSS5FudcbZQkEE8s7CYLonBpBvhFx7B7/SdgySttkp7
	 ZbFEmEU3FsTt+ZT2otBK6QO95dcApSYEvNXBHYb4Y5dXUtCGrsB9ozoeoHcqdgx+VwKCn
	 9Eur+YCNPCrGAvyMZMHVxrpo3fgUi8GojYFjhZXWdbHCRBVcO2WIP2Ih4keTauIjgGnLA
	 3JmhXQjo7HFSLSfDt8UPVh1NVCxccpv4UKFXmtVSd9WmFKgjjPvYQkukNShtbjLHKhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aSMTooUqetPPz0uT7u16XjpOCh2rtMpHXUZ/GcEDa/M=;
	b=U7V1slBtKqZ9XIusUIrxwhve5RFeCqgTeTQ3K90FBZQnzGlk+OVTGAHWbD+985eNviZu
	 3TsYMUzfqN54IV8f8m5atHHA/G1QfQV1VcD1pen4n3Unh+uQVSsMi1La6eAU+iK0m//BN
	 RdXhEoWHvLJUtzb+GVjDgPJId23AIzfx/igpQ/cEK81OZD4HgmG4qOb+Con+IxgiEMYjp
	 CCZnx7NN5OsgoN4O6P62o7gJddNwpFindsjuckIUMxVGOt/CrXw64nFhB+oL7ruKVLjLD
	 5gv5vyCr/Gto5vpOT9k03mnaAgFTukxWeZ4V2qcLm4N2SjO4Vm9RwQN9X1aIymv6WdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314881;
	bh=aSMTooUqetPPz0uT7u16XjpOCh2rtMpHXUZ/GcEDa/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHzzlHRrTwaA/7wUyi5YY8xZEoYIfB8w8xk8XgalUMTRwIBsojhMfVsg5cBtf2x+p
	 5FvTOBaBLH2+IK6lBQSWrELsFnGIztvQvnkwmD2zIFmEsUC3SXizjLgbCoUZ//4Mgv
	 o1p+wS+UZFvh0q6EDvriUF8Gb6cklr4lvmrsyMJNa7jS96+ffgTV8RJl9yDYwoGcoN
	 TUASBqhqb3+gdyLQMNVTg9jIV4EjArbmvRV0HpMv78SvVBTXu7PTa9AxvFrCefGoL3
	 rOqZ8U4B9NuM12sexkdOZXrxTwjOAk0f2npEbih3ibbZzTnur+UWX3Wrm3N8xLiyPB
	 FYEsibhyROajA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8FE180B08;
	Sun, 22 Nov 2026 02:34:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 791A979D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FDCF40176
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15NBHWHTVuoW for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4019540012
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZLbgJxAh
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4019540012
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 556D241A25;
 Sun, 22 Nov 2026 02:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F51F000C6;
 Sun, 22 Nov 2026 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314877;
 bh=aSMTooUqetPPz0uT7u16XjpOCh2rtMpHXUZ/GcEDa/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZLbgJxAhE71vIcRdkQ8JiG5ZOl90wp4iDuazN9FfvWqvMnXGyeU58R9S/PlCXTaEF
 Fch5t0VKywujVDCfzFT+gz8Mkvgk3P23ZN/RNpXNXOYBqSnbu9IwrLw7b9lKDQFcK1
 miT9r2qTjXW9QfvIJ59sRleZifGjlkZCVAZY++rnx2qRwukNp0yeiKzDK0+3GsMRT9
 T2hdmuHWo2/Uatjlwue7k5DnXzTqttfVdBN+0MwOVkq4sYX1L/A6ruXNdhpEzJZu6i
 BK6yd4naE5p9apQacgS+rtdsCC/MNi80Ig+HNZ5C3Q4SQ2ip7pb+nLURJU0F6HNKWG
 crhDgxtzVm3gA==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 22 Nov 2026 02:34:10 +0000
Subject: [PATCH 2/5] riscv: spacemit: k3: set boot device to SPI NOR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-2-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=757; i=dlan@kernel.org;
 h=from:subject:message-id; bh=aLT0695X4PlJSBFbJMzZ3y4Rtjw19n+VnCfipd3pXqA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlSqCNT27aRiSWlgr+52dyXA8NPYKBDgscwLG
 jWLZXSJvRKJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUqhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0RxQ/9Hr/yjF+uOdg4S1aXQ0a07fPr2PWSAvftuKYB8AgOwlKZqXSFPFj4p
 1ECkVUqh/+Nb7xMCwLnQRRwUnwuIx9s6ZbvxA9zsDEczVVyiGUM2Yfb5LKstKHwulTKyYpB0Cyc
 gneGDk5HUyCJEp3tUyXKCAYYwj6Qrk4RUMYhyexNSINFwIhhA8eOPSkB/t9I4gbHaQl3A70JDIv
 yBi0PHQlp1aYa9rVFMO4NdGFXDRYrHU9oHqi9rCb2JgQywzPhiZqUgj6mBHBnwtUBrfHp9aMlaV
 Bo2hgGqMMoygmnmBGSZJk5jMz8QH7fRji2R5wwq+8PRLPzMDgs/JWytn6jLtY+I0XRJk2bezCUh
 a0sV9s7Lty18h0OM9SRXB9c1InSQKImGgpqtrwGzr1stmTkAVlTvcmxCIA3c2k+H0wS4AIa/Jto
 cZy7GaQXcd4u2g7F3Gfmp+BC6NvUABuvIbMXjQ/Bxm4V3e4hS7FPYy0D5FpbBt2Dm9lYCCrMdpY
 Iv5jX2PISn7o0DGakVGb450NQSvMyM9Z91S1vtNgOjKIIglVNTK47x4HWrw96EgOrTH7BMNXw1d
 b1fwRHGQHCyGEWvqaTnuq3a3Kgv0uV6l+YsIE1adU+A5/OFLNHIUB+oMcHBJ/DzwN606eZNw+kr
 mC2BAkSDcWyqL/AYWV/qk8Acx98aJQ=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Configure SPI NOR as the boot device, so it's able to boot from NOR
flash successfully.

Signed-off-by: Yixun Lan <dlan@kernel.org>

---
We need to implement boot device auto detection function as K1 SoC,
so it won't need to hardcode to specific storage media.
---
 board/spacemit/k3/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
index 250e91b93a8..1011230a052 100644
--- a/board/spacemit/k3/spl.c
+++ b/board/spacemit/k3/spl.c
@@ -123,7 +123,7 @@ int spl_board_init_f(void)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_NONE;
+	return BOOT_DEVICE_SPI;
 }
 
 void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)

-- 
2.56.0


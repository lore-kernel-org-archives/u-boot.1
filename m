Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F66606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dult0Z45;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DizuikLl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FAC46074C;
	Sat, 24 Oct 2026 22:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bD4Al0MWvtdz; Sat, 24 Oct 2026 22:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 781F6606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881348;
	b=RXPSLBD2TUa8SoavCG4X9FwUKP63bHDzI1cTCZ0a9+WXLx33poaQjJcNsiwpGy6C9aoB
	 258iXPqiDe+7RO+bepdwUoZzzHqd8qV1KYcWQasMI3LDGwUjjVXj0dqZKiKtpxCCKD6Ry
	 m/rg/B8V5eU+qRcl7CxY/WgWhu2+0APv5aNFjwrLIzR6vfVhX+pT+m7R2Xx+RnhRxDT3W
	 TQ+9cM+Cssu8Yh3xEwW30USTIsh5muu4nO3psWiT432L249UttmH+qe/P5sWslyTp8EPB
	 ZxqZGFyaZYUUYeiuA9BuVu8ofxRg11BhvtJgG8ieDDR5n3W+YFIRVr23gBOX9OEkb5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pcAU4cqQ0eUhxXlx6PgKbcv6uEsirIhQjdLjR9MBzz4=;
	b=DiaIO7f5gcy7M20Clkgx6eb6fs3FB4tLqdOHdquizEUhAL468QfHgwhlRTIdZAOZYb0n
	 O3xmSR8m1czVSMalVBmHT9BfZRWomh4ssM3O54+2oGHECTrdKm9z6DW+T2hpADs/uz2Ej
	 5k4RPsydzEJWKRKWMFdkuxSqmJDhRKrXLz/DN4DFuCRvm/dmpmTxgalNJ4NH+VeGgvPGb
	 te++s9ImgkQGnME/nTF/nKo5iXNL0Y+1YZXHdPuXLIS3nH8DX+WCpPFXhm9QPPP4gE1nx
	 fZ//0Jdm9d2+BJwCtrz1Cuo2K3H8AbfhuVwdIR4N+DyG2+4t+JwuMfMcsM0Cwhf+gIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881348;
	bh=pcAU4cqQ0eUhxXlx6PgKbcv6uEsirIhQjdLjR9MBzz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dult0Z45kJKLae7qw4/eui1SH/uXugz3f71XR0Vn5LGe5+kK1MWlGOKk2tOFul9MA
	 jKdbd4RUTgsc8pNCtoqhhzBMy/efZ8cd82TWZu3NXL4iPUVtVfpGbgBrI6yarmvYMM
	 zlBsl9quIiFtvCA+/j3nCGAr8+ecnzTtyZ8qeXj1Aj9462L3y6NhOD2Yk6IbX7ahbg
	 q3vyCKga+7rIV429FMWlko6YxkC59zHKHRVBGuKf+YkilOQ9NdkrLw9Z/4oJ9JMn8U
	 o01GRnOIBk8WmOTs7FPZ9hZL2rVKoVfSLNzTFA/dW2lFQhWwlWyjJJbQWw+fqlqisW
	 6ELeEC5uFZR4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 781F6606F8;
	Sat, 24 Oct 2026 22:35:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A6952F5
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7069640079
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gddPowHim9Cf for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0972A4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881342;
 b=Dy7fmwHngKnwvY4rxNUMgJ+TRJgdTynLj+a9ZwLXRh9fwcQ95wHo6C3VkOFQY6ddmLFY
 H9dGNXoT1VfofezpcUIbxNN67lpKr78+F4b765UlAdoujjQDvbFgXYzZ6Xrwfu9QA1saQ
 0F0itbCl1Npx97Iu+htOjaDfzmsNen4/1+flfejDn3SeylSGtlO1Sb/OooImYR8a65qsV
 LVUqTbZNnKHguwtdvtAQDdh+h1xix1uzftukUCiaPd2gseUQyte23s8b3L8FCZzwtGm+r
 t+jLTof3EHCDYa4GbVLKFMzUTh4PSuJZrBxe1/vJTWcnCCY6EwYC7HZNX2wQs+dkbmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=pcAU4cqQ0eUhxXlx6PgKbcv6uEsirIhQjdLjR9MBzz4=;
 b=REYLs1UAHOkGqZYlHHVjxTpjQ7iH7LLsnt92eZLzPe+72Umcmgj9vvWzjva6fz950Pv0
 iCD14dRqJRxSz3v8SL7JIzi7hehkdVVpB4/iHKZ59wsJfNPWmgrG2zecaAHQGvtBQl+xE
 1QYn/NAtUmWAMlwv7X8xOSc32lKExaKklrp/8cc7zV/sUMiN+X2iCjlU6yvBj1QBhNLvK
 FmHAIn2Y+RaM9efWX0LTZUdXH9rAyY1YqJGaSNQ3taVzt3Ms1gJKjyKoDjd36aD+XqqZy
 tF2KLFFrBH0ItGRfgf77ngknBqIaEs2tcyc4T9gd8S+j0QBMlALEg214k9muQYHEBrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DizuikLl; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DizuikLl
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0972A4006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:41 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-490d838b425so967406fac.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881341; x=1793486141;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pcAU4cqQ0eUhxXlx6PgKbcv6uEsirIhQjdLjR9MBzz4=;
 b=DizuikLlFNL1Ri3OUtiTufSi1F07s99bT4kErg8yt6DcQs83HDew7eNU0lG6hUdmaJ
 +G56Om8PSiPpEhuW9qeTybgVLOFa91e7+iLlUShnnFjhSl/Cx1UujWTwjhpKYmJyZ3ko
 rApDuUAZ2mz68bG+R1FNTVKdn8Yv7SbnQxlW6GuwgLB+wOPHydUhtdMfy8xifa5TwHGg
 BCmYkUb3Un2FFbUjg6w8qvfaJL7lCMXum7ogPjMtZbrMhbdT93XqKsVs4fo/9hZtfOzk
 66UmjlgZpRVnL13Lnxuz0wnVtRg66M90neHXtr0IsUVHgEKkvkH40KDylkbB6gTDVdtb
 Lnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881341; x=1793486141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcAU4cqQ0eUhxXlx6PgKbcv6uEsirIhQjdLjR9MBzz4=;
 b=G8zeCMwVKCn0yOuJu+0nNU7MxK8fH8DfBUPTFB85u9Zw4BaWoRf+N0sOwGtOjcdYqr
 kalHPegAR86jFevOh0/fNeO1Ggbvru9lYGTkF2v2R0hq+8WEUhidfXIw5Fd8mZFKU5zi
 ZnHj5CAyW24EzXeAEhguYQ4gSqsK85iJSpOmt/3kAiHuhfNY9lapg3Hzj5ZtdFR2nTuh
 x4zm1EVyf4mOrZgVKxOAjwlUOEmHgn2SYmeQorYEcScHK05ZRbPc+v3WCUwU7IYIr9yQ
 vTpMTqmCSZotNJuwnULNJQ0DQsj2c2Up0SUomaT+UtbxrLUZzORrJD4j2UzqUCXHpnTa
 SEvA==
X-Gm-Message-State: AFq9FYI0SI6Op2h7rjmnKCcCQaI+v2mAaHUuElZPXqr/4QkvcHuTl2bu
 Hljw45oRxjG5jICGnPJyVnSVFOC34OFDrkGmo6jhbVQnpADXX0nL453h
X-Gm-Gg: AYBFou2VU5IIa6HvTNm4ptgsxA4KGnyt9QvAGp29zhRrp1k2rLtVSbHnZgqMjt+jciQ
 M7JE10zNUkApFbcXITRgOru1oSMVUGON068h7dSlWdV18L+bmFQVn8oj275iAQBpr3MpNyiVW3l
 ZXY0ufF6qXUDwqeLrnvq8RWquB/4GuRc+uUR3s2T0xYD4WKhI8hf32nCzWYbbJu1OO45kTwH92N
 BlpqMaK4KhRfa+aX940wXT1e7k1zNqteE6Kp+3gLzc9G6aE7eCYhM4xG5vZoes79hnq2IqxJMXu
 AFgf4hg8xvs3jcgicm2N5hDCPG8bVB6XLWmWuL0fcy01zKgx6K9vYsPoRsA5q/+PGbvSAtCmWHl
 15SjP2dPnI1XUUfqtQdNL64dEhbLgfmxRmnym//GZvcmI3S2rmz+do56A+/mwqNXbZ7nLlow8w6
 sbFsYI5xPnPcm1wCuL7f3Hiv4B0HfsMMAfszc8MWJc1uKohKRvp+gfvWJGYUv/fIQqxWVnj8Bzp
 Zz6xRHJrdywZnHoZTtPJRias1l4FZizpuGI8QNWCGeqPtRK5LfAgcYjEL7JHUyJQi6hRoGdLveU
 S4p8xny5EgSP/uwZTxPH9HuJ0WpMcRjrqhVGr86UaRYMF1fcVupiYNYGxrGchwKRrzdTqh/1O3f
 LtO8oRvuEUzdGHs2i00RZNtq4n0re7Jop/YEzDBl26PiNDQ5l/O2HiOeIz5qgL1Ug8/ZFUxkT3r
 mYWYo=
X-Received: by 2002:a05:6870:2106:b0:4a7:4452:bcb6 with SMTP id
 586e51a60fabf-4a83f579d76mr1865867fac.38.1792881340714; 
 Sat, 24 Oct 2026 15:35:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:35:02 -0600
Subject: [PATCH v2 15/16] net: lwip: keep DHCP and BOOTP autoload retries
 with their caller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-15-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
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

Retire DHCP/BOOTP before TFTP borrows its runtime for one download
attempt. Allow the address-configuration owner to refresh the interface
from the environment after publishing the acquired configuration.

A retryable download failure must repeat address acquisition and
obtain fresh boot configuration on the selected interface. Share one
network retry budget between acquisition and download, and preserve
BOOTP_MAY_FAIL's scope as an address-acquisition policy.

Perform autostart only after the parent's protocol callbacks, runtime
attachment and option data have been released. Keep internal helpers
download-only and refuse to restart another client's shared runtime.

Exercise refreshed leases, servers and filenames, interface rotation,
shared retry budgets and autostart cleanup in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/net-lwip.h   |  1 +
 net/lwip/dhcp.c      | 52 ++++++++++++++++++++----------
 net/lwip/net-lwip.c  | 17 +++++-----
 net/lwip/tftp.c      | 48 +++++++++++++++++++++-------
 test/dm/lwip.c       |  4 +++
 test/dm/lwip_bootp.c | 24 ++++++++++++++
 test/dm/lwip_dhcp.c  | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 199 insertions(+), 37 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index e67497bddec..8fd1c094dff 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -81,6 +81,7 @@ int net_lwip_restart(struct net_lwip_ctx *ctx);
 int net_lwip_refresh(struct net_lwip_ctx *ctx);
 int net_lwip_poll(void);
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
+int net_lwip_tftp_download(struct net_lwip_ctx *net, int argc, char *const argv[]);
 
 /**
  * wget_validate_uri() - varidate the uri
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 1b92dd7b8a1..28c1064add8 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -6,6 +6,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <hexdump.h>
+#include <image.h>
 #include <log.h>
 #include <lwip-dhcp.h>
 #include <malloc.h>
@@ -958,6 +959,8 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct dhcp_options *options;
 	const char *autoload;
 	const char *filename = NULL;
+	bool downloaded = false;
+	bool acquisition_timeout;
 	ulong addr;
 	char *end;
 	const char *hostname, *vendor;
@@ -1027,25 +1030,46 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = bootp_loop(&net, !!filename, options);
 		if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
 			ret = dhcp_loop(&net, !!filename, options);
-		if (ret != -ETIMEDOUT)
-			break;
+		/* Retire the address protocol before handing its runtime to TFTP. */
 		if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
 			dhcp_retire(&net);
-		if (IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) &&
+		acquisition_timeout = ret == -ETIMEDOUT;
+		if (!ret) {
+			autoload = env_get("autoload");
+			if ((autoload && !strcmp(autoload, "NFS")) ||
+			    env_get_yesno("autoload") == 0)
+				break;
+			if (!IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+				log_err("Cannot autoload with TFTP: command is disabled\n");
+				ret = CMD_RET_FAILURE;
+				break;
+			}
+			ret = net_lwip_refresh(&net);
+			if (ret)
+				break;
+			if (IS_ENABLED(CONFIG_CMD_TFTPBOOT))
+				ret = net_lwip_tftp_download(&net, argc, argv);
+			if (ret != -EAGAIN) {
+				downloaded = !ret;
+				break;
+			}
+			puts("Starting again\n\n");
+		} else if (!acquisition_timeout) {
+			break;
+		}
+		/* BOOTP_MAY_FAIL limits address acquisition, not TFTP recovery. */
+		if (acquisition_timeout && IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) &&
 		    (env_get_yesno("ethrotate") == 0 || net_restart_wrap))
 			break;
 		/* Other runtime clients must not lose their interface on retry. */
 		ret = net_lwip_restart(&net);
-		if (ret || (IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) && net_restart_wrap)) {
+		if (ret || (acquisition_timeout && IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) &&
+			    net_restart_wrap)) {
 			ret = CMD_RET_FAILURE;
 			break;
 		}
 	}
-	/*
-	 * A download needs strict addressing, incompatible with the
-	 * address-less runtime attachment. Retire DHCP before handing off;
-	 * the BOOTP loop has already removed its receive callback.
-	 */
+	/* No protocol callbacks may survive the shared runtime or option data. */
 	if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
 		dhcp_retire(&net);
 	active_options = NULL;
@@ -1054,6 +1078,8 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (ret)
 		return CMD_RET_FAILURE;
+	if (downloaded)
+		return net_boot_file_size ? bootm_maybe_autostart(cmdtp, argv[0]) : 0;
 	autoload = env_get("autoload");
 	if (autoload && !strcmp(autoload, "NFS")) {
 		if (IS_ENABLED(CONFIG_CMD_NFS))
@@ -1061,13 +1087,7 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		log_err("Cannot autoload with NFS: command is disabled\n");
 		return CMD_RET_FAILURE;
 	}
-	if (env_get_yesno("autoload") == 0)
-		return CMD_RET_SUCCESS;
-	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT))
-		return do_tftpb(cmdtp, flag, argc, argv);
-	log_err("Cannot autoload with TFTP: command is disabled\n");
-
-	return CMD_RET_FAILURE;
+	return CMD_RET_SUCCESS;
 }
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index df11322ec3b..60fcf9b3225 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -553,25 +553,26 @@ int net_lwip_restart(struct net_lwip_ctx *ctx)
 
 /**
  * net_lwip_refresh - Refresh environment addressing for the shared interface
- * @ctx: Active environment-addressed client attachment
+ * @ctx: Active client attachment
  *
- * Address-less clients take priority, so flexible-client refreshes are
- * deferred until the last such client detaches. A refresh which would change
- * the address while a strict client is attached fails with -EBUSY.
+ * The address configuration owner may refresh after publishing its acquired
+ * configuration and retiring DHCP/BOOTP, before starting an autoload transfer.
+ * Flexible-client refreshes are deferred while that owner remains attached.
+ * A refresh which would change the address while a strict client is attached
+ * fails with -EBUSY.
  *
  * Return: 0 on success, or a negative error code.
  */
 int net_lwip_refresh(struct net_lwip_ctx *ctx)
 {
 	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
-	    ctx->dev != net_lwip_runtime.dev ||
-	    ctx->addr_mode == NET_LWIP_ADDR_NONE)
+	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
 		return -EINVAL;
 
-	if (net_lwip_runtime.no_addr_users)
+	if (net_lwip_runtime.no_addr_users && ctx->addr_mode != NET_LWIP_ADDR_NONE)
 		return 0;
 
-	return net_lwip_configure(ctx->addr_mode);
+	return net_lwip_configure(NET_LWIP_ADDR_ENV_FLEXIBLE);
 }
 
 /*
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 9e19857d19b..21c5e885a92 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -612,10 +612,11 @@ static void tftp_default_filename(struct net_lwip_ctx *net, char *fname,
 	printf("*** Warning: no boot file name; using '%s'\n", fname);
 }
 
-static int do_tftp(int argc, char *const argv[], enum tftp_operation operation)
+static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
+		   struct net_lwip_ctx *parent)
 {
 	struct net_lwip_ctx local = {};
-	struct net_lwip_ctx *net = &local;
+	struct net_lwip_ctx *net = parent ?: &local;
 	u32 timeout_msecs = UBOOT_TFTP_TIMEOUT_MS;
 	u32 max_retries = UBOOT_TFTP_MAX_RETRIES;
 	int ret = CMD_RET_SUCCESS;
@@ -785,12 +786,14 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation)
 		goto out;
 	}
 
-	if (net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT)) {
-		ret = CMD_RET_FAILURE;
-		goto out;
+	if (!parent) {
+		if (net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT)) {
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		net_try_count = 1;
+		net_restart_wrap = 0;
 	}
-	net_try_count = 1;
-	net_restart_wrap = 0;
 
 	for (;;) {
 		ret = tftp_check_ip(net);
@@ -802,7 +805,8 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation)
 		ret = tftp_loop(net, operation, laddr, size,
 				fname && *fname ? fname : default_fname, srvip,
 				port, srcport, timeout_msecs, max_retries);
-		if (ret != -EAGAIN)
+		/* Autoload retries must reacquire the parent's boot configuration. */
+		if (ret != -EAGAIN || parent)
 			break;
 		/* The failed transfer's PCB and timers are already gone. Never
 		 * change interfaces underneath another shared-runtime client.
@@ -814,18 +818,38 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation)
 	}
 	if (!ret && operation == TFTP_DOWNLOAD)
 		image_load_addr = laddr;
-	ret = ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+	if (!parent)
+		ret = ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 out:
-	net_lwip_stop(net);
+	if (!parent)
+		net_lwip_stop(net);
 	free(arg_copy);
 	return ret;
 }
 
+/**
+ * net_lwip_tftp_download() - Attempt autoload using the caller's runtime
+ * @net: Active attachment with configured addressing and DHCP already retired
+ * @argc: Number of command arguments
+ * @argv: BOOTP/DHCP command arguments, using the tftpboot argument syntax
+ *
+ * Keep runtime and retry ownership with BOOTP/DHCP. All TFTP callbacks and
+ * timers are removed before returning. The caller handles autostart after
+ * releasing its own resources.
+ *
+ * Return: 0 on success, -EAGAIN for a retryable transfer failure, or another
+ * nonzero value for a terminal error.
+ */
+int net_lwip_tftp_download(struct net_lwip_ctx *net, int argc, char *const argv[])
+{
+	return do_tftp(argc, argv, TFTP_DOWNLOAD, net);
+}
+
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret;
 
-	ret = do_tftp(argc, argv, TFTP_DOWNLOAD);
+	ret = do_tftp(argc, argv, TFTP_DOWNLOAD, NULL);
 	if (ret || !net_boot_file_size)
 		return ret;
 	/* The transfer's callbacks and runtime attachment are already gone. */
@@ -834,5 +858,5 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return do_tftp(argc, argv, TFTP_UPLOAD);
+	return do_tftp(argc, argv, TFTP_UPLOAD, NULL);
 }
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 8bb7e2bad9a..4dd4a562434 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -304,6 +304,10 @@ static int _dm_test_lwip_runtime(struct unit_test_state *uts,
 #if CONFIG_IS_ENABLED(PROT_DHCP_LWIP)
 	ut_assertok(lwip_test_dhcp_stop(uts, no_addr_client->netif));
 #endif
+	/* The configuration owner can publish its lease before autoload. */
+	ut_assertok(net_lwip_refresh(no_addr_client));
+	ip4addr_aton("1.1.2.4", &expected);
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(client_b->netif), &expected));
 	net_lwip_stop(no_addr_client);
 	ip4addr_aton("1.1.2.4", &expected);
 	ut_assert(ip4_addr_cmp(netif_ip4_addr(client_b->netif), &expected));
diff --git a/test/dm/lwip_bootp.c b/test/dm/lwip_bootp.c
index 3f29e2691d2..c6f5876c085 100644
--- a/test/dm/lwip_bootp.c
+++ b/test/dm/lwip_bootp.c
@@ -44,6 +44,7 @@ struct bootp_test {
 	unsigned int requests;
 	unsigned int bind_after;
 	unsigned int tftp;
+	unsigned int transfer_failures;
 	u32 tftp_server;
 	u32 xid;
 	u16 secs;
@@ -268,6 +269,11 @@ static int bootp_tx(struct udevice *dev, void *packet, unsigned int len)
 		data = (void *)(reply_ip + 1);
 		put_unaligned_be16(test->transfer_fail ? 5 : 3, data);
 		put_unaligned_be16(1, data + 2);
+		if (test->transfer_failures) {
+			put_unaligned_be16(5, data);
+			put_unaligned_be16(3, data + 2);
+			test->transfer_failures--;
+		}
 		data[4] = 'x';
 		data[5] = 0;
 		priv->recv_packet_length[priv->recv_packets++] =
@@ -471,6 +477,24 @@ static int bootp_check(struct unit_test_state *uts, struct bootp_test *test)
 	ut_asserteq(CMD_RET_FAILURE, do_bootp(NULL, 0, 3, argv));
 	ut_assert(!test->port_busy);
 	ut_assertnull(netif_default);
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		ut_assertok(env_set("netretry", "once"));
+		for (i = 0; i < 2; i++) {
+			*test = (struct bootp_test){ .transfer_failures = 1 };
+			ut_assertok(env_set("ethact", "eth@10002000"));
+			ut_assertok(env_set("ethrotate", i ? NULL : "no"));
+			ut_assertok(env_set("ipaddr5", NULL));
+			ut_assertok(do_bootp(NULL, 0, 3, argv));
+			ut_asserteq(2, test->requests);
+			ut_asserteq(2, test->tftp);
+			ut_asserteq_str("explicit.bin", test->filename);
+			ut_asserteq_str(i ? "eth@10003000" : "eth@10002000", env_get("ethact"));
+			ut_assert(!test->port_busy);
+			ut_assertnull(netif_default);
+		}
+		ut_assertok(env_set("ethact", "eth@10002000"));
+		ut_assertok(env_set("netretry", "no"));
+	}
 	/*
 	 * Plain and RFC 1048 replies without siaddr retain the configured server,
 	 * but must clear stale TFTP overrides before the download handoff.
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index 60b4d2a311e..d7e1360d2de 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -22,12 +22,18 @@ struct dhcp_handoff_test {
 	bool timeout;
 	bool dhcp_alive;
 	bool rx_burst;
+	bool refresh_offer;
+	unsigned int discovers;
+	unsigned int drop_acquisitions;
+	unsigned int tftp_failures;
 	unsigned int rx_packets;
 	int rx_error;
 	unsigned int tftp;
 	unsigned int nfs;
 	u32 boot_server;
 	u32 nfs_server;
+	u32 tftp_server;
+	u32 tftp_local;
 	char filename[128];
 };
 
@@ -44,6 +50,12 @@ static int dhcp_handoff_reply(struct udevice *dev, struct dhcp_msg *request)
 
 	if (type != DHCP_DISCOVER && type != DHCP_REQUEST)
 		return 0;
+	if (type == DHCP_DISCOVER)
+		test->discovers++;
+	if (net_try_count <= test->drop_acquisitions) {
+		timer_test_add_offset(1000001);
+		return 0;
+	}
 	if (test->timeout) {
 		timer_test_add_offset(10001);
 		return 0;
@@ -67,6 +79,11 @@ static int dhcp_handoff_reply(struct udevice *dev, struct dhcp_msg *request)
 	put_unaligned_be32(test->boot_server, &reply->siaddr);
 	reply->cookie = htonl(DHCP_MAGIC_COOKIE);
 	strlcpy((char *)reply->file, test->offer, sizeof(reply->file));
+	if (test->refresh_offer && test->discovers > 1) {
+		put_unaligned_be32(0x01010205, &reply->yiaddr);
+		put_unaligned_be32(0x01010204, &reply->siaddr);
+		strcpy((char *)reply->file, "second.bin");
+	}
 	pos = reply->options;
 	*pos++ = DHCP_OPTION_MESSAGE_TYPE;
 	*pos++ = 1;
@@ -137,6 +154,8 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	    get_unaligned_be16(ip + 1) != 1)
 		return 0;
 	test->tftp++;
+	test->tftp_server = ntohl(ip->ip_dst.s_addr);
+	test->tftp_local = ntohl(ip->ip_src.s_addr);
 	test->dhcp_alive |= !!netif_dhcp_data(netif_default);
 	strlcpy(test->filename, (char *)(ip + 1) + 2, sizeof(test->filename));
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -160,6 +179,11 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	data = (void *)(reply_ip + 1);
 	put_unaligned_be16(test->fail ? 5 : 3, data);
 	put_unaligned_be16(1, data + 2);
+	if (test->tftp_failures) {
+		put_unaligned_be16(5, data);
+		put_unaligned_be16(3, data + 2);
+		test->tftp_failures--;
+	}
 	data[4] = 'x';
 	data[5] = 0;
 	priv->recv_packet_length[priv->recv_packets++] =
@@ -193,6 +217,64 @@ static void dhcp_handoff_free_pkt(struct udevice *dev, int len)
 	       sizeof(arp->dipaddr));
 }
 
+static int dhcp_autoload_retries(struct unit_test_state *uts,
+				 struct dhcp_handoff_test *test)
+{
+	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
+	struct net_lwip_ctx other = {};
+	int i, ret;
+
+	if (!IS_ENABLED(CONFIG_CMD_TFTPBOOT))
+		return 0;
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("netretry", "once"));
+	for (i = 0; i < 3; i++) {
+		*test = (struct dhcp_handoff_test){
+			.offer = "first.bin", .refresh_offer = true, .tftp_failures = 1,
+		};
+		ut_assertok(env_set("ethact", "eth@10002000"));
+		ut_assertok(env_set("ethrotate", i == 2 ? NULL : "no"));
+		ut_assertok(env_set("ipaddr5", NULL));
+		ut_assertok(env_set("serverip", "1.1.2.2"));
+		ut_assertok(do_dhcp(NULL, 0, i == 1 ? 3 : 1, argv));
+		ut_asserteq(2, test->discovers);
+		ut_asserteq(2, test->tftp);
+		ut_asserteq(0x01010205, test->tftp_local);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_SERVERIP) ||
+			    IS_ENABLED(CONFIG_BOOTP_PREFER_SERVERIP) ?
+			    0x01010202 : 0x01010204, test->tftp_server);
+		ut_asserteq_str(i == 1 ? "explicit.bin" : "second.bin", test->filename);
+		ut_asserteq_str(i == 2 ? "eth@10003000" : "eth@10002000", env_get("ethact"));
+		ut_assert(!test->dhcp_alive);
+		ut_assertnull(netif_default);
+	}
+	/* An acquisition retry and a transfer retry share the same budget. */
+	*test = (struct dhcp_handoff_test){
+		.offer = "first.bin", .drop_acquisitions = 1, .tftp_failures = 1,
+	};
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(1, test->tftp);
+	ut_asserteq(0, test->tftp_failures);
+	ut_assertnull(netif_default);
+
+	/* An autoload failure must not restart another client's runtime. */
+	*test = (struct dhcp_handoff_test){ .offer = "first.bin", .tftp_failures = 1 };
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(net_lwip_start(&other, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	ret = do_dhcp(NULL, 0, 1, argv);
+	i = other.netif == netif_default && !netif_dhcp_data(other.netif);
+	net_lwip_stop(&other);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i);
+	ut_asserteq(1, test->discovers);
+	ut_asserteq(1, test->tftp);
+	ut_assertnull(netif_default);
+	ut_assertok(env_set("netretry", "no"));
+	return 0;
+}
+
 static int dhcp_handoff_check(struct unit_test_state *uts,
 			      struct dhcp_handoff_test *test)
 {
@@ -207,6 +289,7 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	ut_assertok(env_set("nfsserverip", NULL));
 	ut_assertok(env_set("tftpdstp", NULL));
 	ut_assertok(env_set("tftpsrcp", NULL));
+	ut_assertok(dhcp_autoload_retries(uts, test));
 	for (i = 0; i < 4; i++) {
 		*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
 		ut_assertok(env_set("autoload", i == 3 ? "no" : "yes"));
@@ -320,7 +403,8 @@ static int dm_test_lwip_dhcp_handoff(struct unit_test_state *uts)
 		"ethact", "ipaddr", "netmask", "gatewayip", "serverip",
 		"tftpserverip", "nfsserverip", "autoload", "autostart", "bootfile",
 		"loadaddr", "dnsip", "dnsip2", "ntpserverip", "filesize", "fileaddr",
-		"tftpdstp", "tftpsrcp",
+		"tftpdstp", "tftpsrcp", "netretry", "ethrotate",
+		"ipaddr5", "netmask5", "gatewayip5",
 	};
 	struct dhcp_handoff_test test = {};
 	char bootfile[sizeof(net_boot_file_name)];
@@ -341,10 +425,14 @@ static int dm_test_lwip_dhcp_handoff(struct unit_test_state *uts)
 	sandbox_eth_set_tx_handler(0, dhcp_handoff_tx);
 	sandbox_eth_set_free_pkt_handler(0, dhcp_handoff_free_pkt);
 	sandbox_eth_set_priv(0, &test);
+	sandbox_eth_set_tx_handler(1, dhcp_handoff_tx);
+	sandbox_eth_set_priv(1, &test);
 	ret = dhcp_handoff_check(uts, &test);
 	sandbox_eth_set_tx_handler(0, NULL);
 	sandbox_eth_set_free_pkt_handler(0, NULL);
 	sandbox_eth_set_priv(0, NULL);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(1, NULL);
 	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
 	image_load_addr = load_addr;
 	for (i = 0; i < ARRAY_SIZE(vars); i++)

-- 
2.53.0


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C70606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WFgKux1l;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pb/tYfnD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 882DD607EB;
	Mon, 16 Nov 2026 18:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QW_hyMh2EQuV; Mon, 16 Nov 2026 18:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D10D9606E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854385;
	b=sOJQdB0DUOOOqAkmsZloCaxlBLuUZB1Hsx5vJQHIbgxHQqnB2j/o4w0Xn7MarM2yD9eR
	 8metfjcEZS7Ip5j2OAUYbfurNbndFdlBp5GlK+vKJ9krI20zhVps4UyDxpIK34A3q3XcW
	 QNprEAmqMkP7MEMINdLYCFijIvtY3MSoBre9pnMN4D9wvDU2GohvAIEuQsBPLxG1jRwl6
	 fjcsi+3UV6JnSUcB1sQKgojquyaffD56iZXsm7mTa39xpusqSFmvhyWnDtTSJUVJpRCXO
	 hIzgZjMFydibIugG9/47sq4XwiY4EMgqUOYay/jB/yomFWfHi9CcogrNyITax9bDrzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Us3hIbo0VO4OMYqCt6aH3g5WonjUWv8X1PmtMtIS34M=;
	b=m3j3g42JAglLluGvQs1WSNaXR8YpTvtDfGblVF+UT8J7VDQ5SObphdwqTNojZ5pokyrm
	 Uh4gKNX/iY5QfIL5FBM0suS4K/7P8P7d3/9AYRCt2FM7jG6V3ebq5ou0q2eJLm3CDxRyI
	 5yLT9inBxnS9fGHGP+lW7s5Y4iCZz96or4rV9Ks0SYgidRapq5HxE+npxpb4J3jof9hkO
	 yZYePxL+9DXuqMvkGIRZJ09N0kzXtTXjALqu0BoSPeZ020C3uSdLPJ1UR3cmJIEXG1gPL
	 sbB43CvAw71O5hktVgGQBTi9pCH8Mu6bhIXPrkjVGXPaJiWJfogyp8YQDNRV5ZrQVhw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854385;
	bh=Us3hIbo0VO4OMYqCt6aH3g5WonjUWv8X1PmtMtIS34M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFgKux1l8ahksDmOizqHF6gNt9ntSnJFhXNTpcV+sjQ8BGqM4r8c3en3FtROh8Lc+
	 xFP0iRa//91Ptr/9kBWB6pfMoBnpUSON0mU4rpqnb8EJgMF//7HdJygFCFZhuyyC4m
	 DfMVEULm9lXiO+OM1AekwrnkWSCoxPIKcRSTTJC+aNW7HLnRy1kMK/imfLYTDxBAhw
	 EAJgn79KGZHMpy8eA7ZsXbr42hSvVKdcMqoOvIVjoLdhlgVYeS5X7MAgwHWq8hEnAL
	 keI+LAD+z+c7+thcJqWKooxsgE5tHva9/i1O4mDBd62m1XOGQsx17Ft2H9d5ZntJ7a
	 OprsFHZR2fFCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D10D9606E0;
	Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45C5C28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 381934009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uz7R1uLQZaXp for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 455344007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pb/tYfnD
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 455344007E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso24181315e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794854380; x=1795459180;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Us3hIbo0VO4OMYqCt6aH3g5WonjUWv8X1PmtMtIS34M=;
 b=pb/tYfnDdxEkxWP5w0gTqLOhQxMipylM2jLLIVSNOpmnXaUCb6Nlha6+cQgAHHBk5x
 m+WpwldrYKQrxxwILrXRxwmF4zQHKPy4LIXDSzjikYokmRPdmPACisLA8ZCJzJo6XRpS
 chA1+XP8ciWeWTlUFq/7gWZhdyvkivGHtir9hCcrSUAW8SRD5kFkiVfym5fz8p4ulrSN
 mbUoiKl0WjBv9/ZIypfivz6GV9ghL8gqQ5axwHi+V8fSsxvh4tYJ+rCmtqfamjcdSO6L
 IZ9M/t/T8jelUGD2D8ZV0JFujzS6cvt4vJ2thJ8sbgdq462SR41qb4jGHW3ItHSL/FhA
 jJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854380; x=1795459180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Us3hIbo0VO4OMYqCt6aH3g5WonjUWv8X1PmtMtIS34M=;
 b=kdzr3KvpvcZ+QFth2sob2W14I+PI3ZLaHytHxSacL4p9AZLeNEkm/JkyLXXt/dVcIY
 7MGn0MUVLhq1TFdMR9TaZ51+wHjE6vyxW0L+vsDelP/Wva3nKy+0bcfPJp1K4lUdSXDh
 TdsqD1/b7lGthfW87tyt5/W6BLtRLuHPuome2cyibvQ1CA5ZQWtrofs+FqDMNEZiRwNa
 1NtCfnIYYI4F+uBF1w+PDontsLACpt8Relh3oarIj8MN19WDyuWO5eWIIzDS2fVqGIaZ
 MMuvYlJa7afBMa+ByBDxAu/GTydTcvcHjvRzLH3bCsaR66SArvnyIg4thgGvub4zEhwX
 ppwA==
X-Gm-Message-State: APuU4Z8FRHOujH/wM1pNR38rSPSq0b3JkpVUHQYvoa+rlq7lMk/UELm3
 BQD6hx6MQEwrBz9TcgwzSJdzuEAviVrJUDmFJhhviXTTqbEuuxznChXHG2CsOA==
X-Gm-Gg: AYBFou0ti/rlSPV2VQ47+QgtW895v4gAsrk9PUIDRU3jSWViIBRzg22EnJLf89dYTPM
 Zdv0cdN8435Pqu7dX4QetGBxDEAbzMnm88H6HxV6oxj1977S2occ8rcvOQWBAVOa3HTheDbm5BM
 cnK7kXza0cZrzgePzOqIM83bKuTCslIh5rq90+Imjv1sBOacE0JMbscatE3gXPT1R9bdwg5Xm+v
 ZTkuZX3Kf+VhrV+i3kqYOBuJKoK7ABfec6Jj2rpyXHUI466zTbGYud8p1CqSDUF0gvz+OVfIg8s
 abFKrA+FmXxjU4mITkMd/d5ZUYFmCy8hn0tbnsrPKeU9URZusKq5GhAnkxNdAXNZCElIFFWQYUX
 TzR8KmXm0Fok33lB7YLpq9Kq/eY/uUkiQSWL/M33IPj0DPjRNy7RHWInKi8iibHZFaYh2RKrm67
 7DlhX33kwMBzk0en30jh1VJ4u9Yti7MykKvw6aII2YQsZb23gAbz/sUMjdaL6IQLdS4HA03hsJy
 LOD35Wr+zqB0IB9AB0uoAh2rBBLO7XqJZUwMZ1sJULHPvmRbMkFJgOyWuorVRslHw2QzxVEr9S/
 B5Wt4jDxlePaTeTX/xWPWLNjwE+iPgj/eHHExcrIiA==
X-Received: by 2002:a05:600c:3b93:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb6f67caf0mr125681815e9.29.1794854379760; 
 Mon, 16 Nov 2026 10:39:39 -0800 (PST)
Received: from [127.0.1.1] ([151.71.173.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm23947618f8f.49.2026.11.16.10.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:39:39 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 16 Nov 2026 19:39:34 +0100
Subject: [PATCH v3 1/3] ram: rockchip: improve sdram type configs selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ddr-multi-v3-1-fe9fb30a3169@gmail.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
In-Reply-To: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not all the SDRAM types configuration options named in the Kconfig
are supported by each of the Rockchip SoCs: improve clarity adding
SoC dependencies to the options.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..74422947452 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -26,26 +26,26 @@ config RAM_ROCKCHIP_DEBUG
 
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
 	help
-	  This enables DDR4 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable DDR4 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR2
 	bool "LPDDR2 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR2 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR2 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR3
 	bool "LPDDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR3 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR3 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR4
+	depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
 	bool "LPDDR4 support for Rockchip SoCs"
 	help
-	  This enables LPDDR4 sdram code support for the platforms based
-	  on Rockchip SoCs.
+	  Enable LPDDR4 sdram support on Rockchip SoCs.
 
 endif # RAM_ROCKCHIP

-- 
2.34.1


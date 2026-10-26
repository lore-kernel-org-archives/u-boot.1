Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80367606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=clukwV2t;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cx1rL9ij
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CD4E80BE5;
	Mon, 26 Oct 2026 23:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvHqe7UXaRYc; Mon, 26 Oct 2026 23:47:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CD5380BF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058422;
	b=KNwxNsNMM2UWIJFakHd7CJtzDlTpo6PLpS+0R39z+diEMwceV9LlYlMB9k6fEAX6oTOl
	 jQizPrMH8bm5usG4LGdt/RPdHUug1N1w4M3Y0K6iMsmaxHoDd/8zNvW7+9JnGFpNoVDZ1
	 UTbAHf4nDSt4dvWrD7BG9WjuJFZq5JI5goN4bcY75vw7vn/uN1XJYXmU6FTfC6B+oNi1k
	 F158nkB8vGfWQVG1+dHDD7YvS8Eku9SwzWoPjPGmAvAJUSlC0+p/iyzTyXQj4s9erX4Np
	 7r84eMsTymmPIPrZoBEiieA0wX0D/+DLLmTOOhnuQoaG7Su7GESD9zsqstMaQllzU1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=J0f3Lt8XNhaonP1XqJWoaEYPKXq+nW7pXs5GZqYROKM=;
	b=KMgRBqGChLWCqEk86kC5qzzylp/neTVzz5ZXZPI+f+t/o96dxJt4vJM5kskN6Wp71dqp
	 nkEeQTTVUj+OguVGi+DFrBDDaGsg1iAwFEbHWGSfDSKWyrCI3T2upRgi3ZHc0oAVbGRIO
	 cclmssVpDJnVymsrqvpIYyOVFCYlX3ZUMdAGdZYMv0JcLU9E8hSo6Pdu4f+xF/KbHlV11
	 RHPQf8ImmpXYB7lfXR1awQ8Z9VrOoKPL4g3hEoyOK4nLfeTxBaGPuNG7PP+Ws/BTeWVbl
	 AnlWTtzQsWbyp28VFswk0B0f7aRIP2A3YFjalgn9fGTRgYvLcnUX2R12Vay1i1zuM0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cx1rL9ij;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058422;
	bh=J0f3Lt8XNhaonP1XqJWoaEYPKXq+nW7pXs5GZqYROKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=clukwV2tXW82+Qv15J+IhDVMLY8dtiO9YecNd0qhu0KpbiDckVBUIJJEu114O9gDz
	 EmDv/cm5MYESteKThLLw9AVNdnVddfJIPv9Bx1fN5qVvxVwFnGw4sg95deOQau0mT9
	 Frq1t5wpd1k0jZIjjfftrTjoUbpDGbCPAmo91RfdvFIEKuF591CQrH7m2gKqSDKsrw
	 Gg6yzzbyV/e7MQ2mQGpFlXdk1rWVrJVzATYIR+tU3fAh5Qnl+nwPrnOFbFLf+Y/In4
	 kUDWSHc/3LbUMLgcCixHbaH4OYDWKC5a/MiSDA9OLiT7MbgH3/WnpRNp0QxpcUCtp+
	 NOIzLuhariS+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CD5380BF5;
	Mon, 26 Oct 2026 23:47:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1E93421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D182E80C12
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4EJOugikiuD for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 102FF80BD3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058413;
 b=er/ICF1Bhw2nIgoFXFjb9oVlMxqg6vIdSd0g1i2o1DTCYgyOkoXd8QVJgRGvFjnwy4t1
 DkX+To9a6nx7qlyLkJcIxfw9n5RcECJJ0t886cz8lnb9r6HvtFebAI8v4yNsSu3RHpDWi
 f2wYJGgiGVxYvKKVFpyOGo0NXkqWCU9N0fi4PAx4hm5SQ1M628mLROfObhQnxSYCDab1Z
 NdljUwpcPyf0td+rMOu22WF7mI6r86Rx++PweCAYq+PyZ9eokFbBeQZlRALJqA25AxjQ4
 bd7EpZzBkWAxuTlvj757qLHrsAGrAgNQ0DBZz8L4d0zf0i+QxBdt0Vsv/CEp00YY86w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=J0f3Lt8XNhaonP1XqJWoaEYPKXq+nW7pXs5GZqYROKM=;
 b=GRoqo4/ujy3b1vYqapMjEHCi28Gae/Y50i7UxeloaeHx9W9bFXwyVXYtauq8M5K8MjQ6
 hCahud4sZIIc5cEoqd7I4xC1UFN3p5Q1D4hdk3J2yDqcfT5cpX4yr8zDA8FmXKfgQJ8nV
 VOR+wmlWpznSs1cH/LmVwec8PI4JM6Or+/3T606BkV8AwU1sflu5Yg5C6U5UZmnpTcyWi
 D6JdUWWMMWBuE40VSgfp5Pz0sv9nwLxiH59NwZCls5kKVHLEfxmphAni2+ZIqq6gqZX0W
 14gOKQk6gels6JPFWv2BshCNXVnNYYsYNzwtZYHO+appbXX2FhiQvZ0YER/LI5IDIvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Cx1rL9ij; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cx1rL9ij
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 102FF80BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-84a248254f4so2329434a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058411; x=1793663211;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J0f3Lt8XNhaonP1XqJWoaEYPKXq+nW7pXs5GZqYROKM=;
 b=Cx1rL9ijZK6e9ei7WirOhboSMLp0QLuwo3GUYTU3n18bUbYIr1hE/BzoGpRY913VB3
 B5D/Zr0wWYvcVmTYXVCEkdaeu26ZqQVpuSBtQ9ykgu6xcCa7/DJOy5wIYRMKYwtc+XH8
 UVxvVFtu7XrALkMVQomipHXQVmz9OTeFkA4fDlcrjSp84nfsVa/M8LhpKvWQrQaOkJAU
 K3n6XP4+FtMm9xN+6X0DRQLBPdsf2F7Yzk5grewZwLFgx+rAuJH6ovlqIFQKElLOzj4m
 JYSGuRojx+Hopy8+vti74K0fGh0/wgFHS8y2G+TBM3kuBC8rPkWK1S8xaqv8WwkHB5Iw
 LkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058411; x=1793663211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J0f3Lt8XNhaonP1XqJWoaEYPKXq+nW7pXs5GZqYROKM=;
 b=Zrllk9mcbggbhvz4wuWYHcsxDZHX8t5z3lvYBMt4QiThWQ4DqoMwGqqnmc6IZyturs
 /sByNl52RDqB0yr6JgXXiNY6CvSd8X5Hg/pLaWawIHFYsnyRNAHXE90A7T83bIpz8CGV
 tFu5WGNmgHNeijgTTEi/09bL0UfvNbjDiEefsFtpFIT5XDb6mp5Ktoaula/1BCOLSPLF
 Qd3QqebVoqPnkxgcB0xaMht5JiO4PbD/YfVZB1tq+SCKCHT/SO+coJPFEp/3cIQVCVA6
 npjJ801LeWAtyPd2yTxQd54utELTpUt0MddoLn/kKDWJ/ey8RtHdb7soEIa/inJ2PH5N
 pZdg==
X-Gm-Message-State: AFq9FYK4MhcrAbRUkwXSPmAlasnUXwR1Qz/q3QUMYMMsK7rWp3w9eUS/
 74f4t8I17GHr/maHXTKd/g6jGmMXl0sA+UJ5xK4BVd+nooXZWaXN/smc
X-Gm-Gg: AYBFou0FKjRJZpTs0vQvUV4B7CHLaQWlRVBD42BxzukB5zAB0u03UsXYkSCDgzcePwr
 KqSjZSEcWdIcfFi16CK3k+mvHX7CTCVIuqyBbptiPzccFC77jZl9ow5skoeVPmFh6XEkTJPjub7
 hWvdlMHGXB8ryxfxGIc+2nZGZnB11CKYir5IIURM2LL3+1H7+D4usy+mQBQCFFqexMCh5qxJV5j
 pz0Kkn9utNKDfLEaOJsDF1LrmUQBhyovqvLiokSj0YhcPAL7s9MvMBsfd8Q3LqWyek7fqPTNlYr
 ko7k3AtoD18e/JU9VRQ9Cyj2nZQLPVZA7uXnI5xQP9Fb0ZFXxM3ar85RyuuxV/em9CgWlnA1jRa
 n8ccy5gR/EE+4DTRE/FsxEqotRgvtaED0jLICE00PEI6WMwbo7HHzFlgaRopVdDDePXg3zhJeKd
 P1F9HqyblDixELSY6DrClZ/3TkDbZjIyQtu1dyLM7DecO2xOBPrVtpSbSXWcDbRLqnv52xBmC9z
 hJjkEjD5iniO5AUJxhhxNWLmWVD9UiWd+VzuHjAnjpNg7lbtOHQM9wldP8fb3FFVFxyx55BmG/q
 pj2hUiTq9WBrPz3enfLeVoXBCXXUuTTzp3nNZyIPgr9cBTxK++846ssGWAqdACOkeOtqFZuuqiT
 IOjmYGLauOut21p+iv05emEBrHrvsh05jADNVNuVF9E8ejxXt2QoIzxbR8rESmlRjX7bcX1kRxJ
 r+v2w=
X-Received: by 2002:a05:6830:3143:b0:80c:d34f:5f66 with SMTP id
 46e09a7af769-850ff7776d0mr9643182a34.31.1793058410805; 
 Mon, 26 Oct 2026 16:46:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:41 -0600
Subject: [PATCH 9/9] net: phy: add X-Powers AC200/AC300 Ethernet PHY
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-9-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
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

Port the mainline Linux ACx00 PHY initialization sequences to U-Boot.
Use the same Ethernet PHY package binding for fixed AC200 and AC300
packages and NVMEM-selected variants. Validate the configuration before
touching either control interface, and require a usable input clock.

Keep the link-side tuning shared and the I2C and secondary-MDIO package
controls in separate backends. Preserve the AC300 external-supply reset
sequence, apply the calibration and interface settings, and wake the PHY
before resetting it. Propagate setup failures and unwind partial starts.

Initialize from the config callback, after U-Boot has assigned the PHY
node and interface. Leave unrelated devices with the same PHY ID on the
generic configuration path. Retain package power across network commands
because the MAC can need the RMII clock before calling PHY startup.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS                      |   3 +-
 drivers/net/phy/Kconfig          |  10 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/xpowers/Makefile |   2 +
 drivers/net/phy/xpowers/ac200.c  | 150 ++++++++++++
 drivers/net/phy/xpowers/ac300.c  | 252 ++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.c  | 485 +++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h  |  40 ++++
 8 files changed, 942 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3a7a121066..28824d651e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1918,10 +1918,11 @@ F:	include/xen.h
 F:	lib/sscanf.c
 F:	test/lib/sscanf.c
 
-X-POWERS AC200
+X-POWERS AC200/AC300
 M:	James Hilliard <james.hilliard1@gmail.com>
 S:	Maintained
 F:	drivers/misc/xpowers-ac200.c
+F:	drivers/net/phy/xpowers/
 F:	include/xpowers-ac200.h
 
 XTENSA
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 02aeb1db977..c2f6cbcc8eb 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -358,6 +358,16 @@ config PHY_VITESSE
 config PHY_XILINX
 	bool "Xilinx Ethernet PHYs support"
 
+config PHY_XPOWERS_ACX00
+	bool "X-Powers AC200/AC300 Ethernet PHY support"
+	depends on PHY_ETHERNET_ID && CLK && DM_REGULATOR && MISC
+	select NVMEM
+	imply XPOWERS_AC200
+	help
+	  Support the Fast Ethernet PHY in AC200 and AC300 companion ICs.
+	  The Linux Ethernet PHY package binding describes the supply, clock
+	  and calibration. AC200 also needs the I2C register provider.
+
 config PHY_XILINX_GMII2RGMII
 	bool "Xilinx GMII to RGMII Ethernet PHYs support"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index bd57fa005b1..effde8f7996 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PHY_TI_GENERIC) += ti_phy_init.o
 obj-$(CONFIG_$(PHASE_)PHY_TI_DP83867) += dp83867.o
 obj-$(CONFIG_PHY_TI_DP83869) += dp83869.o
 obj-$(CONFIG_PHY_XILINX) += xilinx_phy.o
+obj-$(CONFIG_PHY_XPOWERS_ACX00) += xpowers/
 obj-$(CONFIG_PHY_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
 obj-$(CONFIG_PHY_XWAY) += intel_xway.o
 obj-$(CONFIG_PHY_ETHERNET_ID) += ethernet_id.o
diff --git a/drivers/net/phy/xpowers/Makefile b/drivers/net/phy/xpowers/Makefile
new file mode 100644
index 00000000000..605ab2bb392
--- /dev/null
+++ b/drivers/net/phy/xpowers/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += acx00.o ac200.o ac300.o
diff --git a/drivers/net/phy/xpowers/ac200.c b/drivers/net/phy/xpowers/ac200.c
new file mode 100644
index 00000000000..fd03a3efb82
--- /dev/null
+++ b/drivers/net/phy/xpowers/ac200.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC200 Ethernet PHY package control
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (c) 2022 Arm Ltd. (Andre Przywara <andre.przywara@arm.com>)
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <xpowers-ac200.h>
+
+#include "acx00.h"
+
+#define AC200_EPHY_BPS_EFFUSE_OFFSET		3
+#define AC200_EPHY_CLK_RATE_24_MHZ		24000000
+#define AC200_EPHY_CLK_RATE_27_MHZ		27000000
+
+#define AC200_SYS_EPHY_CTL0_REG			0x0014
+#define AC200_EPHY_RESET_DEASSERT		BIT(0)
+#define AC200_EPHY_SYSCLK_ENABLE			BIT(1)
+#define AC200_SYS_EPHY_CTL1_REG			0x0016
+#define AC200_EPHY_MII_IO_ENABLE			BIT(0)
+#define AC200_EFUSE_EPHY_REG			0x8004
+#define AC200_EPHY_CTL_REG			0x6000
+#define AC200_EPHY_SHUTDOWN			BIT(0)
+#define AC200_EPHY_CLK_SEL_24_MHZ		BIT(2)
+#define AC200_EPHY_PHY_ADDR_MASK			GENMASK(8, 4)
+#define AC200_EPHY_RMII_SEL			BIT(11)
+#define AC200_EPHY_BPS_EFFUSE_MASK		GENMASK(15, 12)
+
+static u16 ac200_ephy_config(const struct acx00_ephy_priv *priv)
+{
+	return priv->control_config |
+		(priv->phydev->interface == PHY_INTERFACE_MODE_RMII ?
+		 AC200_EPHY_RMII_SEL : 0) |
+		FIELD_PREP(AC200_EPHY_PHY_ADDR_MASK, priv->phydev->addr);
+}
+
+int ac200_ephy_power_on(struct acx00_ephy_priv *priv)
+{
+	u16 config;
+	int ret;
+
+	if (priv->phydev->addr > FIELD_MAX(AC200_EPHY_PHY_ADDR_MASK))
+		return -EINVAL;
+	if (priv->powered)
+		return 0;
+
+	config = ac200_ephy_config(priv);
+	/* Make a failed partial start run the complete shutdown sequence. */
+	priv->powered = true;
+
+	ret = ac200_write(priv->control, AC200_SYS_EPHY_CTL0_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = ac200_write(priv->control, AC200_SYS_EPHY_CTL1_REG,
+			  AC200_EPHY_MII_IO_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = ac200_write(priv->control, AC200_EPHY_CTL_REG,
+			  config | AC200_EPHY_SHUTDOWN);
+	if (ret)
+		return ret;
+
+	ret = ac200_write(priv->control, AC200_SYS_EPHY_CTL0_REG,
+			  AC200_EPHY_RESET_DEASSERT |
+			  AC200_EPHY_SYSCLK_ENABLE);
+	if (ret)
+		return ret;
+
+	return ac200_write(priv->control, AC200_EPHY_CTL_REG, config);
+}
+
+int ac200_ephy_power_off(struct acx00_ephy_priv *priv)
+{
+	int err;
+	int ret;
+
+	if (!priv->powered)
+		return 0;
+
+	ret = ac200_write(priv->control, AC200_EPHY_CTL_REG,
+			  ac200_ephy_config(priv) | AC200_EPHY_SHUTDOWN);
+	err = ac200_write(priv->control, AC200_SYS_EPHY_CTL1_REG, 0);
+	if (!ret)
+		ret = err;
+	err = ac200_write(priv->control, AC200_SYS_EPHY_CTL0_REG, 0);
+	if (!ret)
+		ret = err;
+
+	priv->powered = false;
+
+	return ret;
+}
+
+int ac200_ephy_init(struct acx00_ephy_priv *priv, ofnode package,
+		    bool has_configuration, u8 calibration)
+{
+	struct ofnode_phandle_args args;
+	ulong clock_rate;
+	u16 internal_calibration;
+	u8 code;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(package, "x-powers,ac200", NULL,
+					     0, 0, &args);
+	if (ret)
+		return ret;
+
+	if (!ofnode_device_is_compatible(args.node, "x-powers,ac200"))
+		return -EINVAL;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, args.node,
+					  &priv->control);
+	if (ret)
+		return ret;
+
+	if (!has_configuration) {
+		ret = ac200_read(priv->control, AC200_EFUSE_EPHY_REG,
+				 &internal_calibration);
+		if (ret)
+			return ret;
+		calibration = internal_calibration;
+	}
+
+	code = (calibration + AC200_EPHY_BPS_EFFUSE_OFFSET) &
+		FIELD_MAX(AC200_EPHY_BPS_EFFUSE_MASK);
+	priv->control_config =
+		FIELD_PREP(AC200_EPHY_BPS_EFFUSE_MASK, code);
+
+	clock_rate = ac200_get_clock_rate(priv->control);
+	if (IS_ERR_VALUE(clock_rate))
+		return (long)clock_rate;
+	switch (clock_rate) {
+	case AC200_EPHY_CLK_RATE_24_MHZ:
+		priv->control_config |= AC200_EPHY_CLK_SEL_24_MHZ;
+		break;
+	case AC200_EPHY_CLK_RATE_27_MHZ:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/phy/xpowers/ac300.c b/drivers/net/phy/xpowers/ac300.c
new file mode 100644
index 00000000000..3ebf67527c6
--- /dev/null
+++ b/drivers/net/phy/xpowers/ac300.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC300 Ethernet PHY package control
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (c) 2022 Arm Ltd. (Andre Przywara <andre.przywara@arm.com>)
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <clk.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include "acx00.h"
+
+#define AC300_EPHY_CONTROL_ADDR_OFFSET		16
+#define AC300_EPHY_BGS_EFFUSE_OFFSET		3
+#define AC300_EPHY_CLK_RATE_24_MHZ		24000000
+#define AC300_EPHY_CLK_RATE_25_MHZ		25000000
+#define AC300_EPHY_CLK_RATE_27_MHZ		27000000
+#define AC300_SYS_CONTROL_REG			0x00
+#define AC300_PACKAGE_STATUS_MASK		GENMASK(11, 8)
+#define AC300_EPHY_CLK_SEL_MASK			GENMASK(7, 6)
+#define AC300_EPHY_CLK_SEL_25_MHZ		0
+#define AC300_EPHY_CLK_SEL_27_MHZ		1
+#define AC300_EPHY_CLK_SEL_24_MHZ		2
+#define AC300_EFUSE_CLK_ENABLE			BIT(5)
+#define AC300_EPHY_REG_CLK_ENABLE		BIT(4)
+#define AC300_CLKIN_GATING_ENABLE		BIT(2)
+#define AC300_EPHY_RESET_DEASSERT		BIT(1)
+#define AC300_CHIP_RESET_DEASSERT		BIT(0)
+#define AC300_PACKAGE_POR_INTERNAL_DLDO		BIT(3)
+#define AC300_PACKAGE_PHY_ADDR_MASK		GENMASK(2, 0)
+#define AC300_SYS_BIAS1_REG			0x02
+#define AC300_INTERNAL_DLDO_ENABLE		BIT(15)
+#define AC300_SYS_IO_REG			0x05
+#define AC300_MDIO_DRV_MASK			GENMASK(15, 14)
+#define AC300_MII_DRV_MASK			GENMASK(11, 10)
+#define AC300_IO_DRV_LEVEL_2			2
+#define AC300_CLKIN_PAD_ENABLE			BIT(4)
+#define AC300_EPHY_MII_IO_ENABLE			BIT(0)
+#define AC300_EPHY_CONFIG_REG			0x06
+#define AC300_EPHY_BGS_EFFUSE_MASK		GENMASK(15, 12)
+#define AC300_EPHY_RMII_SEL			BIT(11)
+#define AC300_EPHY_SHUTDOWN			BIT(0)
+
+#define AC300_SYS_CONTROL_ENABLE_BITS \
+	(AC300_EFUSE_CLK_ENABLE | AC300_EPHY_REG_CLK_ENABLE | \
+	 AC300_CLKIN_GATING_ENABLE | AC300_EPHY_RESET_DEASSERT | \
+	 AC300_CHIP_RESET_DEASSERT)
+
+#define AC300_SYS_IO_VALUE \
+	(FIELD_PREP(AC300_MDIO_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
+	 FIELD_PREP(AC300_MII_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
+	 AC300_CLKIN_PAD_ENABLE | AC300_EPHY_MII_IO_ENABLE)
+
+static int ac300_ephy_read(struct acx00_ephy_priv *priv, int reg)
+{
+	return priv->phydev->bus->read(priv->phydev->bus,
+				       priv->phydev->addr +
+				       AC300_EPHY_CONTROL_ADDR_OFFSET,
+				       MDIO_DEVAD_NONE, reg);
+}
+
+static int ac300_ephy_write(struct acx00_ephy_priv *priv, int reg, u16 value)
+{
+	return priv->phydev->bus->write(priv->phydev->bus,
+					priv->phydev->addr +
+					AC300_EPHY_CONTROL_ADDR_OFFSET,
+					MDIO_DEVAD_NONE, reg, value);
+}
+
+static int ac300_ephy_modify(struct acx00_ephy_priv *priv, int reg,
+			     u16 mask, u16 set)
+{
+	int value;
+
+	value = ac300_ephy_read(priv, reg);
+	if (value < 0)
+		return value;
+
+	return ac300_ephy_write(priv, reg,
+				(value & ~mask) | (set & mask));
+}
+
+static u16 ac300_ephy_config(const struct acx00_ephy_priv *priv)
+{
+	return priv->control_config |
+		(priv->phydev->interface == PHY_INTERFACE_MODE_RMII ?
+		 AC300_EPHY_RMII_SEL : 0);
+}
+
+static u16 ac300_ephy_reset_value(const struct acx00_ephy_priv *priv)
+{
+	return !priv->ac300_package_known || !priv->ac300_internal_dldo ?
+		AC300_CHIP_RESET_DEASSERT : 0;
+}
+
+int ac300_ephy_power_off(struct acx00_ephy_priv *priv)
+{
+	int clk_ret = 0;
+	int err;
+	int ret = 0;
+
+	if (priv->powered) {
+		ret = ac300_ephy_write(priv, AC300_EPHY_CONFIG_REG,
+				       ac300_ephy_config(priv) |
+				       AC300_EPHY_SHUTDOWN);
+		err = ac300_ephy_write(priv, AC300_SYS_IO_REG, 0);
+		if (!ret)
+			ret = err;
+		err = ac300_ephy_write(priv, AC300_SYS_CONTROL_REG,
+				       ac300_ephy_reset_value(priv));
+		if (!ret)
+			ret = err;
+
+		priv->powered = false;
+	}
+
+	if (priv->clk_enabled) {
+		clk_ret = clk_disable(&priv->clk);
+		if (!clk_ret)
+			priv->clk_enabled = false;
+	}
+
+	return ret ? ret : clk_ret;
+}
+
+int ac300_ephy_power_on(struct acx00_ephy_priv *priv)
+{
+	u8 package_status;
+	int sys_control;
+	int ret;
+
+	if (priv->powered)
+		return 0;
+	if (!priv->clk_enabled) {
+		ret = clk_enable(&priv->clk);
+		if (ret)
+			return ret;
+		priv->clk_enabled = true;
+	}
+
+	priv->powered = true;
+	ret = ac300_ephy_write(priv, AC300_SYS_CONTROL_REG,
+			       ac300_ephy_reset_value(priv));
+	if (ret)
+		goto err_power_off;
+
+	ret = ac300_ephy_write(priv, AC300_SYS_CONTROL_REG,
+			       AC300_EPHY_RESET_DEASSERT |
+			       AC300_CHIP_RESET_DEASSERT);
+	if (ret)
+		goto err_power_off;
+
+	ret = ac300_ephy_write(priv, AC300_SYS_CONTROL_REG,
+			       priv->ac300_sys_control);
+	if (ret)
+		goto err_power_off;
+
+	sys_control = ac300_ephy_read(priv, AC300_SYS_CONTROL_REG);
+	if (sys_control < 0) {
+		ret = sys_control;
+		goto err_power_off;
+	}
+
+	package_status = FIELD_GET(AC300_PACKAGE_STATUS_MASK, sys_control);
+	if ((~package_status & AC300_PACKAGE_PHY_ADDR_MASK) !=
+	    priv->phydev->addr) {
+		ret = -EINVAL;
+		goto err_power_off;
+	}
+
+	priv->ac300_internal_dldo =
+		package_status & AC300_PACKAGE_POR_INTERNAL_DLDO;
+	priv->ac300_package_known = true;
+	ret = ac300_ephy_modify(priv, AC300_SYS_BIAS1_REG,
+				AC300_INTERNAL_DLDO_ENABLE,
+				priv->ac300_internal_dldo ?
+				AC300_INTERNAL_DLDO_ENABLE : 0);
+	if (ret)
+		goto err_power_off;
+
+	ret = ac300_ephy_write(priv, AC300_SYS_IO_REG, AC300_SYS_IO_VALUE);
+	if (ret)
+		goto err_power_off;
+
+	mdelay(10);
+	ret = ac300_ephy_write(priv, AC300_EPHY_CONFIG_REG,
+			       ac300_ephy_config(priv) | AC300_EPHY_SHUTDOWN);
+	if (ret)
+		goto err_power_off;
+
+	mdelay(10);
+	ret = ac300_ephy_write(priv, AC300_EPHY_CONFIG_REG,
+			       ac300_ephy_config(priv));
+	if (ret)
+		goto err_power_off;
+
+	return 0;
+
+err_power_off:
+	ac300_ephy_power_off(priv);
+
+	return ret;
+}
+
+int ac300_ephy_init(struct acx00_ephy_priv *priv, ofnode package,
+		    u8 calibration)
+{
+	ulong clock_rate;
+	u8 code;
+	int ret;
+
+	if (priv->phydev->addr > FIELD_MAX(AC300_PACKAGE_PHY_ADDR_MASK))
+		return -EINVAL;
+
+	ret = clk_get_by_index_nodev(package, 0, &priv->clk);
+	if (ret)
+		return ret;
+	clock_rate = clk_get_rate(&priv->clk);
+	if (IS_ERR_VALUE(clock_rate))
+		return (long)clock_rate;
+	switch (clock_rate) {
+	case AC300_EPHY_CLK_RATE_24_MHZ:
+		priv->ac300_sys_control =
+			FIELD_PREP(AC300_EPHY_CLK_SEL_MASK,
+				   AC300_EPHY_CLK_SEL_24_MHZ);
+		break;
+	case AC300_EPHY_CLK_RATE_25_MHZ:
+		priv->ac300_sys_control =
+			FIELD_PREP(AC300_EPHY_CLK_SEL_MASK,
+				   AC300_EPHY_CLK_SEL_25_MHZ);
+		break;
+	case AC300_EPHY_CLK_RATE_27_MHZ:
+		priv->ac300_sys_control =
+			FIELD_PREP(AC300_EPHY_CLK_SEL_MASK,
+				   AC300_EPHY_CLK_SEL_27_MHZ);
+		break;
+	default:
+		return -EINVAL;
+	}
+	priv->ac300_sys_control |= AC300_SYS_CONTROL_ENABLE_BITS;
+
+	code = (calibration + AC300_EPHY_BGS_EFFUSE_OFFSET) &
+		FIELD_MAX(AC300_EPHY_BGS_EFFUSE_MASK);
+	priv->control_config =
+		FIELD_PREP(AC300_EPHY_BGS_EFFUSE_MASK, code);
+
+	return 0;
+}
diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
new file mode 100644
index 00000000000..a659a0cda2f
--- /dev/null
+++ b/drivers/net/phy/xpowers/acx00.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC200/AC300 Ethernet PHY driver
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (c) 2022 Arm Ltd. (Andre Przywara <andre.przywara@arm.com>)
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <nvmem.h>
+#include <phy.h>
+#include <power/regulator.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+
+#include "acx00.h"
+
+#define ACX00_EPHY_ID				0x00441400
+
+#define ACX00_EPHY_CONFIG_CALIBRATION_MASK	GENMASK(3, 0)
+#define ACX00_EPHY_CONFIG_VARIANT_AC300		BIT(8)
+#define ACX00_EPHY_CONFIG_CALIBRATION_LOW	BIT(9)
+
+#define ACX00_PAGE_SELECT_REG			0x1f
+#define ACX00_PAGE_SELECT_MASK			GENMASK(12, 8)
+#define ACX00_PAGE_0				0
+#define ACX00_PAGE_1				1
+#define ACX00_PAGE_2				2
+#define ACX00_PAGE_6				6
+#define ACX00_PAGE_8				8
+
+#define ACX00_PAGE0_GLOBAL_CONFIG_REG		0x13
+#define ACX00_PAGE0_XMII_RX_CLOCK_INVERT	BIT(12)
+#define ACX00_PAGE0_MDI_MODE_MASK		GENMASK(1, 0)
+#define ACX00_PAGE0_MDI_MODE_AUTO		2
+
+#define ACX00_PAGE1_APS_CONTROL_REG		0x12
+#define ACX00_PAGE1_APS_DISABLED_4S_VALUE	0x4824
+#define ACX00_PAGE1_UAPS_CONTROL_REG		0x13
+#define ACX00_PAGE1_UAPS_ENABLE			BIT(15)
+#define ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG	0x17
+#define ACX00_PAGE1_INTELLIGENT_EEE_ENABLE	BIT(3)
+
+#define ACX00_PAGE2_TX_DATA_CONTROL_REG		0x18
+#define ACX00_PAGE2_10BT_FIR_SELECT_MASK		GENMASK(14, 12)
+
+#define ACX00_PAGE6_ADC_CONTROL_REG		0x10
+#define ACX00_PAGE6_ADC_CONTROL_LOW_CAL_VALUE	0x5523
+#define ACX00_PAGE6_AFE_RX_CONTROL_REG		0x13
+#define ACX00_PAGE6_AFE_RX_CONTROL_VALUE		0xf000
+#define ACX00_PAGE6_AFE_EQ_RX_DETECT_CONTROL_REG	0x14
+#define AC200_PAGE6_AFE_EQ_RX_DETECT_VALUE	0x708f
+#define AC300_PAGE6_AFE_EQ_RX_DETECT_VALUE	0x708b
+#define ACX00_PAGE6_AFE_EQ_RX_DETECT_LOW_CAL_VALUE 0x7809
+#define ACX00_PAGE6_TX_LEVEL_REG			0x15
+#define ACX00_PAGE6_TX_LEVEL_DEFAULT_VALUE	0x1530
+#define ACX00_PAGE6_TX_LEVEL_LOW_CAL_VALUE	0x3533
+
+#define ACX00_PAGE8_AFE_CONTROL_REG		0x18
+#define ACX00_PAGE8_AFE_CONTROL_VALUE		0x00bc
+#define ACX00_PAGE8_AUTO_CAL_CONTROL_REG		0x1d
+#define ACX00_PAGE8_AUTO_CAL_LOW_VALUE		0x0844
+
+static int acx00_ephy_read_page(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read(phydev, MDIO_DEVAD_NONE, ACX00_PAGE_SELECT_REG);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(ACX00_PAGE_SELECT_MASK, ret);
+}
+
+static int acx00_ephy_write_page(struct phy_device *phydev, int page)
+{
+	return phy_write(phydev, MDIO_DEVAD_NONE, ACX00_PAGE_SELECT_REG,
+			 FIELD_PREP(ACX00_PAGE_SELECT_MASK, page));
+}
+
+static int acx00_ephy_modify_paged(struct phy_device *phydev, int page,
+				   int reg, u16 mask, u16 set)
+{
+	int oldpage;
+	int ret;
+
+	oldpage = phy_select_page(phydev, page);
+	if (oldpage < 0)
+		return phy_restore_page(phydev, oldpage, 0);
+
+	ret = phy_modify(phydev, MDIO_DEVAD_NONE, reg, mask, set);
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int acx00_ephy_read_configuration(ofnode package, u16 *configuration,
+					 bool *present, size_t min_len)
+{
+	struct nvmem_cell cell;
+	u8 buf[sizeof(*configuration)] = {};
+	int ret;
+
+	*present = ofnode_stringlist_search(package, "nvmem-cell-names",
+					    "configuration") >= 0;
+	if (!*present) {
+		*configuration = 0;
+		return 0;
+	}
+
+	ret = nvmem_cell_get_by_name_nodev(package, "configuration", &cell);
+	if (ret)
+		return ret;
+	if (cell.size < min_len || cell.size > sizeof(buf))
+		return cell.size > sizeof(buf) ? -ERANGE : -EINVAL;
+
+	ret = nvmem_cell_read(&cell, buf, cell.size);
+	if (ret)
+		return ret;
+
+	*configuration = buf[0];
+	if (cell.size == sizeof(buf))
+		*configuration |= (u16)buf[1] << 8;
+
+	return 0;
+}
+
+static int acx00_ephy_select_variant(ofnode package,
+				     enum acx00_variant *variant,
+				     u16 *configuration, bool *present)
+{
+	bool selectable;
+	bool fixed_ac300;
+	int ret;
+
+	selectable = ofnode_device_is_compatible(package,
+						 "x-powers,acx00-ephy-package");
+	fixed_ac300 = ofnode_device_is_compatible(package,
+						  "x-powers,ac300-ephy-package");
+	if (!selectable && !fixed_ac300 &&
+	    !ofnode_device_is_compatible(package,
+					 "x-powers,ac200-ephy-package"))
+		return -ENODEV;
+
+	ret = acx00_ephy_read_configuration(package, configuration, present,
+					    selectable || fixed_ac300 ? 2 : 1);
+	if (ret)
+		return ret;
+	if ((selectable || fixed_ac300) && !*present)
+		return -EINVAL;
+
+	if (selectable)
+		*variant = *configuration & ACX00_EPHY_CONFIG_VARIANT_AC300 ?
+			ACX00_VARIANT_AC300 : ACX00_VARIANT_AC200;
+	else
+		*variant = fixed_ac300 ? ACX00_VARIANT_AC300 :
+			ACX00_VARIANT_AC200;
+
+	if (!selectable && *present &&
+	    !!(*configuration & ACX00_EPHY_CONFIG_VARIANT_AC300) !=
+	    (*variant == ACX00_VARIANT_AC300))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int acx00_ephy_get_regulator(ofnode package, struct udevice **vcc)
+{
+	struct ofnode_phandle_args args;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(package, "vcc-supply", NULL, 0,
+					     0, &args);
+	if (ret)
+		return ret;
+
+	return uclass_get_device_by_ofnode(UCLASS_REGULATOR, args.node, vcc);
+}
+
+static int acx00_ephy_power_off(struct acx00_ephy_priv *priv)
+{
+	int supply_ret = 0;
+	int ret;
+
+	if (priv->variant == ACX00_VARIANT_AC300)
+		ret = ac300_ephy_power_off(priv);
+	else
+		ret = ac200_ephy_power_off(priv);
+
+	if (priv->supply_enabled) {
+		supply_ret = regulator_set_enable_if_allowed(priv->vcc, false);
+		if (!supply_ret)
+			priv->supply_enabled = false;
+	}
+
+	return ret ? ret : supply_ret;
+}
+
+static int acx00_ephy_power_on(struct acx00_ephy_priv *priv)
+{
+	int ret;
+
+	if (!priv->supply_enabled) {
+		ret = regulator_set_enable_if_allowed(priv->vcc, true);
+		if (ret)
+			return ret;
+		priv->supply_enabled = true;
+		mdelay(10);
+	}
+
+	if (priv->variant == ACX00_VARIANT_AC300)
+		ret = ac300_ephy_power_on(priv);
+	else
+		ret = ac200_ephy_power_on(priv);
+	if (ret)
+		acx00_ephy_power_off(priv);
+
+	return ret;
+}
+
+static int acx00_ephy_vendor_config(struct acx00_ephy_priv *priv)
+{
+	struct phy_device *phydev = priv->phydev;
+	u16 afe_eq_rx_detect;
+	u16 tx_level;
+	u16 global_config;
+	int oldpage;
+	int ret = 0;
+
+	afe_eq_rx_detect = priv->variant == ACX00_VARIANT_AC300 ?
+		AC300_PAGE6_AFE_EQ_RX_DETECT_VALUE :
+		AC200_PAGE6_AFE_EQ_RX_DETECT_VALUE;
+	tx_level = ACX00_PAGE6_TX_LEVEL_DEFAULT_VALUE;
+	global_config = FIELD_PREP(ACX00_PAGE0_MDI_MODE_MASK,
+				   ACX00_PAGE0_MDI_MODE_AUTO);
+	if (priv->xmii_rx_clock_inverted)
+		global_config |= ACX00_PAGE0_XMII_RX_CLOCK_INVERT;
+
+	ret = acx00_ephy_modify_paged(phydev, ACX00_PAGE_0,
+				      ACX00_PAGE0_GLOBAL_CONFIG_REG,
+				      ACX00_PAGE0_XMII_RX_CLOCK_INVERT |
+				      ACX00_PAGE0_MDI_MODE_MASK,
+				      global_config);
+	if (ret)
+		return ret;
+
+	if (priv->variant == ACX00_VARIANT_AC300 &&
+	    priv->use_low_calibration_tuning) {
+		afe_eq_rx_detect =
+			ACX00_PAGE6_AFE_EQ_RX_DETECT_LOW_CAL_VALUE;
+		tx_level = ACX00_PAGE6_TX_LEVEL_LOW_CAL_VALUE;
+	}
+
+	oldpage = phy_select_page(phydev, ACX00_PAGE_1);
+	if (oldpage < 0)
+		goto out_restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			ACX00_PAGE1_APS_CONTROL_REG,
+			ACX00_PAGE1_APS_DISABLED_4S_VALUE);
+	if (ret)
+		goto out_restore_page;
+	ret = phy_modify(phydev, MDIO_DEVAD_NONE,
+			 ACX00_PAGE1_UAPS_CONTROL_REG,
+			 ACX00_PAGE1_UAPS_ENABLE, 0);
+	if (ret)
+		goto out_restore_page;
+	ret = phy_modify(phydev, MDIO_DEVAD_NONE,
+			 ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
+			 ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_2);
+	if (ret)
+		goto out_restore_page;
+	ret = phy_modify(phydev, MDIO_DEVAD_NONE,
+			 ACX00_PAGE2_TX_DATA_CONTROL_REG,
+			 ACX00_PAGE2_10BT_FIR_SELECT_MASK, 0);
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_6);
+	if (ret)
+		goto out_restore_page;
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			ACX00_PAGE6_AFE_EQ_RX_DETECT_CONTROL_REG,
+			afe_eq_rx_detect);
+	if (ret)
+		goto out_restore_page;
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			ACX00_PAGE6_AFE_RX_CONTROL_REG,
+			ACX00_PAGE6_AFE_RX_CONTROL_VALUE);
+	if (ret)
+		goto out_restore_page;
+	if (priv->variant == ACX00_VARIANT_AC300 &&
+	    priv->use_low_calibration_tuning) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE,
+				ACX00_PAGE6_ADC_CONTROL_REG,
+				ACX00_PAGE6_ADC_CONTROL_LOW_CAL_VALUE);
+		if (ret)
+			goto out_restore_page;
+	}
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			ACX00_PAGE6_TX_LEVEL_REG, tx_level);
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_8);
+	if (ret)
+		goto out_restore_page;
+	if (priv->variant == ACX00_VARIANT_AC300 &&
+	    priv->use_low_calibration_tuning) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE,
+				ACX00_PAGE8_AUTO_CAL_CONTROL_REG,
+				ACX00_PAGE8_AUTO_CAL_LOW_VALUE);
+		if (ret)
+			goto out_restore_page;
+	}
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			ACX00_PAGE8_AFE_CONTROL_REG,
+			ACX00_PAGE8_AFE_CONTROL_VALUE);
+
+out_restore_page:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int acx00_ephy_full_config(struct acx00_ephy_priv *priv)
+{
+	int ret;
+
+	ret = acx00_ephy_power_on(priv);
+	if (ret)
+		return ret;
+
+	/* Reset can be acknowledged in power-down without restarting the PHY. */
+	ret = phy_modify(priv->phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret)
+		goto err_power_off;
+
+	ret = phy_reset(priv->phydev);
+	if (ret)
+		goto err_power_off;
+
+	ret = acx00_ephy_vendor_config(priv);
+	if (ret)
+		goto err_power_off;
+
+	ret = genphy_config_aneg(priv->phydev);
+	if (ret)
+		goto err_power_off;
+
+	return 0;
+
+err_power_off:
+	acx00_ephy_power_off(priv);
+
+	return ret;
+}
+
+static int acx00_ephy_init_package(struct phy_device *phydev,
+				   struct acx00_ephy_priv *priv)
+{
+	ofnode package;
+	bool has_configuration;
+	u16 configuration;
+	u32 base_addr;
+	u8 calibration;
+	int ret;
+
+	package = ofnode_get_parent(phydev->node);
+	if (!ofnode_valid(package))
+		return -EINVAL;
+
+	ret = ofnode_read_u32(package, "reg", &base_addr);
+	if (ret || base_addr != phydev->addr)
+		return -EINVAL;
+
+	ret = acx00_ephy_select_variant(package, &priv->variant,
+					&configuration,
+					&has_configuration);
+	if (ret)
+		return ret;
+
+	ret = acx00_ephy_get_regulator(package, &priv->vcc);
+	if (ret)
+		return ret;
+
+	calibration = FIELD_GET(ACX00_EPHY_CONFIG_CALIBRATION_MASK,
+				configuration);
+	priv->use_low_calibration_tuning =
+		priv->variant == ACX00_VARIANT_AC300 &&
+		configuration & ACX00_EPHY_CONFIG_CALIBRATION_LOW;
+	priv->xmii_rx_clock_inverted =
+		ofnode_read_bool(package, "x-powers,xmii-rx-clock-inverted");
+
+	if (priv->variant == ACX00_VARIANT_AC300)
+		return ac300_ephy_init(priv, package, calibration);
+
+	return ac200_ephy_init(priv, package, has_configuration, calibration);
+}
+
+static int acx00_ephy_config(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv;
+	ofnode package;
+	int ret;
+
+	if (!ofnode_valid(phydev->node))
+		return genphy_config(phydev);
+	package = ofnode_get_parent(phydev->node);
+	if (!ofnode_valid(package) ||
+	    (!ofnode_device_is_compatible(package,
+					 "x-powers,ac200-ephy-package") &&
+	     !ofnode_device_is_compatible(package,
+					  "x-powers,ac300-ephy-package") &&
+	     !ofnode_device_is_compatible(package,
+					  "x-powers,acx00-ephy-package")))
+		return genphy_config(phydev);
+
+	if (phydev->interface != PHY_INTERFACE_MODE_MII &&
+	    phydev->interface != PHY_INTERFACE_MODE_RMII)
+		return -EINVAL;
+
+	if (phydev->priv) {
+		/* Apply a newly selected MII/RMII interface before resetting. */
+		ret = acx00_ephy_power_off(phydev->priv);
+		if (ret)
+			return ret;
+		return acx00_ephy_full_config(phydev->priv);
+	}
+
+	priv = calloc(1, sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+	priv->phydev = phydev;
+
+	ret = acx00_ephy_init_package(phydev, priv);
+	if (ret)
+		goto err_free;
+
+	phydev->priv = priv;
+	ret = acx00_ephy_full_config(priv);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	phydev->priv = NULL;
+	free(priv);
+
+	return ret;
+}
+
+static int acx00_ephy_startup(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	int ret;
+
+	if (!priv)
+		return genphy_startup(phydev);
+
+	if (!priv->powered) {
+		ret = acx00_ephy_full_config(priv);
+		if (ret)
+			return ret;
+	}
+
+	return genphy_startup(phydev);
+}
+
+U_BOOT_PHY_DRIVER(xpowers_acx00) = {
+	.name = "X-Powers AC200/AC300 EPHY",
+	.uid = ACX00_EPHY_ID,
+	.mask = 0xfffffff0,
+	.features = PHY_BASIC_FEATURES,
+	.config = acx00_ephy_config,
+	.startup = acx00_ephy_startup,
+	/* The MAC may need the PHY's RMII clock before its next startup call. */
+	.shutdown = genphy_shutdown,
+	.read_page = acx00_ephy_read_page,
+	.write_page = acx00_ephy_write_page,
+};
diff --git a/drivers/net/phy/xpowers/acx00.h b/drivers/net/phy/xpowers/acx00.h
new file mode 100644
index 00000000000..4131dc125c4
--- /dev/null
+++ b/drivers/net/phy/xpowers/acx00.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __XPOWERS_EPHY_H
+#define __XPOWERS_EPHY_H
+
+#include <clk.h>
+#include <dm/ofnode.h>
+#include <phy.h>
+
+enum acx00_variant {
+	ACX00_VARIANT_AC200,
+	ACX00_VARIANT_AC300,
+};
+
+struct acx00_ephy_priv {
+	struct phy_device *phydev;
+	struct udevice *control;
+	struct udevice *vcc;
+	struct clk clk;
+	enum acx00_variant variant;
+	u16 control_config;
+	u16 ac300_sys_control;
+	bool use_low_calibration_tuning;
+	bool xmii_rx_clock_inverted;
+	bool clk_enabled;
+	bool ac300_package_known;
+	bool ac300_internal_dldo;
+	bool supply_enabled;
+	bool powered;
+};
+
+int ac200_ephy_power_on(struct acx00_ephy_priv *priv);
+int ac200_ephy_power_off(struct acx00_ephy_priv *priv);
+int ac300_ephy_power_on(struct acx00_ephy_priv *priv);
+int ac300_ephy_power_off(struct acx00_ephy_priv *priv);
+int ac200_ephy_init(struct acx00_ephy_priv *priv, ofnode package,
+		    bool has_configuration, u8 calibration);
+int ac300_ephy_init(struct acx00_ephy_priv *priv, ofnode package,
+		    u8 calibration);
+
+#endif

-- 
2.53.0


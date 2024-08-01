Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E830C3DA7F
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 01:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985B688AB9;
	Thu,  1 Aug 2024 03:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="EuAqbZQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C46D88AB9; Thu,  1 Aug 2024 03:01:15 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D9488ABE
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 03:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sw0312.kim@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240801010105epoutp03008163cae5fccc817df1e1b5f656820b~ndQlmZkHP2492424924epoutp03m
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 01:01:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240801010105epoutp03008163cae5fccc817df1e1b5f656820b~ndQlmZkHP2492424924epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1722474065;
 bh=Ge2eVW9npf/wt75iuRDXILCzQoBxTtA61mjJPg0APkE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=EuAqbZQ9L580xVNLy3AlDLuWbjNlPb3qgLPsTaX5tSSc4U2NgVsAPAUxvr2WkYPzH
 O1jXEFtIGHW7WqdPGB+y2f6/v3DV0mUDUtnL3a9U9IE/cxH2vTWwH5/xTYjc6XESAI
 T25qnbKArUFZIVFCsFLxDZXnhOVCA/blvP9yd4PY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240801010105epcas1p482e6cd2d56be545cdab988f7b37b7e5d~ndQlSoyxi1734317343epcas1p4l;
 Thu,  1 Aug 2024 01:01:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4WZ9dD30bgz4x9Px; Thu,  1 Aug
 2024 01:01:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 91.2F.09734.05EDAA66; Thu,  1 Aug 2024 10:01:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99~ndQkBgVO83143131431epcas1p3R;
 Thu,  1 Aug 2024 01:01:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240801010104epsmtrp1aff64076b60ad80bd0ab039b758904cd~ndQkAws501156411564epsmtrp1R;
 Thu,  1 Aug 2024 01:01:04 +0000 (GMT)
X-AuditID: b6c32a39-8f9ff70000002606-82-66aade50c832
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.69.07567.F4EDAA66; Thu,  1 Aug 2024 10:01:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240801010103epsmtip2ff03cb0c520963ef40c1ca6c40408a17~ndQjv9ggR2122721227epsmtip23;
 Thu,  1 Aug 2024 01:01:03 +0000 (GMT)
From: Seung-Woo Kim <sw0312.kim@samsung.com>
To: u-boot@lists.denx.de, jagan@amarulasolutions.com,
 andre.przywara@arm.com, trini@konsulko.com
Cc: sw0312.kim@samsung.com, jh80.chung@samsung.com
Subject: [PATCH] tools: imagetool: Remove unnecessary check from
 toc0_verify_cert_item()
Date: Thu,  1 Aug 2024 10:01:00 +0900
Message-Id: <20240801010100.21009-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmgW7AvVVpBtu2ilqsmPeT0eLLpgls
 Fjd+tbFazJj8ks1i6qTN7BZv93ayO7B5rP14n9Vjzbw1jB6vDqxi9zh7ZwejR9+WVYwBrFHZ
 NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAJygplCXm
 lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjOu
 He9nKXjAVtH+jKOB8RprFyMnh4SAicSKyW+AbC4OIYEdjBL9F6ayQTifGCUuHjgBlfnGKLFo
 0w5mmJYzt14zQST2ArW0/2CBcL4wSkw6c4sNpIpNQEdi/5LfYEtEBJIkvvStAetmFjCS2HJ+
 ExOILSwQJbFn3lxGEJtFQFXi0IrXYPW8AtYSF2dsZoTYJi9xYcMtqLigxMmZT1gg5shLNG+d
 zQyyWELgGLvE28fzWSAaXCS+LF3KDmELS7w6vgXKlpJ42d/GDtHQzCjx/tktRginh1Fiw7QF
 UN3GEvuXTgY6jwNohabE+l36ENv4JN597WEFCUsI8Ep0tAlBVKtI7Dw6iQ0iLCUxa0MwRNhD
 4nTrK7CwkECsxLzpVhMY5WYh+WAWkg9mIaxawMi8ilEstaA4Nz212LDAFB6Ryfm5mxjBKU/L
 cgfj9Lcf9A4xMnEwHmKU4GBWEuEVOrkyTYg3JbGyKrUoP76oNCe1+BCjKTBMJzJLiSbnA5Nu
 Xkm8oYmlgYmZkbGJhaGZoZI475krZalCAumJJanZqakFqUUwfUwcnFINTNm64T4tYT71CmtO
 /DX7+Hpx0wOFLXty1S/tKrSY0HyZUSum7x+zuab7lUst3t/z/LtbTvbMTfS3bX57NYH1PIuB
 wwxNiwPmG7nO/tdcrfioadv2Q0untc+NPzHhWAH77AWf4/c+m13S8IBjNov31b/PDlhv0+zw
 P/HYSfCIqKroWfY7oWqrdp0yElKuZwlhmngv6+YyE+9fLMb5c9WkZzUKtO88Kx+960fTv7IH
 psnTRIL41nCcZlHMfdUXunHVkUYR3ZKVlzQ+Gk5XE2RMTRJvO3JjCt/k6afFl34QW3Ns+f4b
 56Mcc5n9W3vTmrxz+zjc+uysrl9xSctb9suLLWhd34Pk42lcAXc1rga9UGIpzkg01GIuKk4E
 AEhbMxgCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvK7/vVVpBttWWlmsmPeT0eLLpgls
 Fjd+tbFazJj8ks1i6qTN7BZv93ayO7B5rP14n9Vjzbw1jB6vDqxi9zh7ZwejR9+WVYwBrFFc
 NimpOZllqUX6dglcGdeO97MUPGCraH/G0cB4jbWLkZNDQsBE4syt10xdjFwcQgK7GSUevp/O
 BpGQkpj7bTtjFyMHkC0scfhwMUTNJ0aJHdtmsYDUsAnoSOxf8htskIhAmsTvt8fBbGagoatv
 tzGB2MICERIPPrwCm8kioCpxaMVrsBpeAWuJizM2M0Lskpe4sOEWVFxQ4uTMJywQc+QlmrfO
 Zp7AyDcLSWoWktQCRqZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBoamlsYPx3vx/
 eocYmTgYDzFKcDArifAKnVyZJsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU
 1ILUIpgsEwenVANT7F6O2bnsC9Z9n7xZzVk3d037d8GNzyt1F78UjOPU1jBczl8i27/71wGL
 zcuO/zy+YFVutNaOJ3OX/r930WfRc+ak0p8zbdtZTLVcghPKCmYu3hncm39iXtXhrPI4h21b
 XdrlT7xVX6An8jTUpd5x1kPzqSWrBNIE/l2IDvCZUNXWwvJ76ZaYXWv2s6w6qTMh+v+ZSyaT
 H5wPZlLM0mlJP+DbsjSu8MDShvCIizq3YzNCp77sjtm8U8LNqd3XPemW7y3FC2EbU7635X94
 fC7WadNZ3R0bdpnyP7YrlnAOrGWdmvDk8QmpVOUrGk5xjO+3btqwqEX86tLSfLNU5bf/z3JN
 eNDj+26P4imvgzmzlFiKMxINtZiLihMB/KurvrwCAAA=
X-CMS-MailID: 20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99
References: <CGME20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99@epcas1p3.samsung.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Remove unnecessary null check from toc0_verify_cert_item()
because the array digest is always not null.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 tools/sunxi_toc0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
index 292649fe90f1..76693647a095 100644
--- a/tools/sunxi_toc0.c
+++ b/tools/sunxi_toc0.c
@@ -444,7 +444,7 @@ static int toc0_verify_cert_item(const uint8_t *buf, uint32_t len, RSA *fw_key,
 
 	/* If a digest was provided, compare it to the embedded digest. */
 	extension = &totalSequence->mainSequence.explicit3.extension;
-	if (digest && memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
+	if (memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
 		pr_err("Wrong firmware digest in certificate\n");
 		goto err;
 	}
-- 
2.19.2


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD570C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 04:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8DF980D1C;
	Wed, 16 Sep 2026 04:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaKifaooLQFc; Wed, 16 Sep 2026 04:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B2A880C98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789532199;
	b=BP0Xk1KvehEJFcdf/O4dDxSXRwai+3sMQ8iCS5zQVCgBtq7Y6I43NUKbDAi71veUj+rd
	 qEu3FXzxxUar6aYMb+4edVawnbgKCQPHvbhgASw4U99zfeamec90Nnv1KLfxv8jdz9htw
	 ue1txLhR/WnDuqLDaj9OtuL5FRrVA9d5Cyhe8MqrY6hBshqzgvzMqP0mfjoh0Q9X3HDTM
	 l4gjhQQewO4WFPfABgPCfcU9P2eHfiILiTL3xbVQSLC2pd5sMw23ZCVFM3C7Y+v8wtYVZ
	 GCDVfyerAhUEkTvEkXhW3ucijeY4GJ/5qbh46GFDXvGmI5qw4fKTHt4aoAHQlHqQF1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789532199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NB07BdvMZ+ShOFZP79O7U/BTpltEis6lsg14/uCWzrA=;
	b=OmCRMvWa7H8LrhJStAOzkJgGVccwBCxzh8Wb7o2LkSLiBAkrHnXuT+oYLc0dUoKkRK9E
	 8fMdTyt4Sqz4+0hger3LlBzxUAWxknHiu8hd/bi8hzx+FtWJndO5PyGapeR/OBderApcr
	 Je4coBe2mROB/74l+5umzqEdYvtGv3W7sm1XvSIkBTUqeVDwGhWOprr8VM1nlCQZQ2sbB
	 9VmPz6URS3YZn8FaGVY7at/JKBJMwcktZpnSRjhB6z/rcsc24y2H0OnqlYOlH0O6wTFwA
	 W/Sp9ssjbU9Bo4Ch414ehPoTtPqHm/n09v6jwNi8qtpdMfDPtB9DQWm5fe0Qekwee0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789532199;
	bh=NB07BdvMZ+ShOFZP79O7U/BTpltEis6lsg14/uCWzrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=014lMD+eTD/ZduNQ4EbHDfOgGudicjDD+DVTtY01BXwWlz7pF9L3vyGviWbIPubRF
	 Us7XFezQecNSNJvpIo68sLtPuPAe9x4ouc62OXbWW+gUxjlkTn1e/RQ8/466xQwtWO
	 9ixWjaTNCkVdVYXsdyrPelNOXQL0rm3/vSxOtKlZsQgJFyOyQWOUZtp6gstVlxhYP2
	 bl3VtBZ0TRCO09a3wHvgRMNYh0vxFf6GHTl8vTe6mjHbZcfewO5wd349EXFtLG2uKT
	 z0A9FySbryaUOylI9ocsXJiuUwKur2FeuZpEZ+PWREUpAPtaH/frLIvlKR6FLEHsBV
	 G3cuyZOvAzhig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B2A880C98;
	Wed, 16 Sep 2026 04:16:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 973D8388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E01240635
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVb9OU-8bNdP for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 04:16:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E767B405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789532197;
 b=cWGBDmkVxRXbZBs+yfEgUCfoh6MFniKttbRcWFnRmrfzilG0GDvg++K5yU36irpjbM4G
 6XXpanSh1ZAiElCxtYrxg62S/vBCqLOVejLTW+8OycsomC9j56WHIXlgKcNva6OYJeCHY
 svtolAZnh60uN97ZTCSXujps1HLtkQ1y+1R8MaDh4a08ko3Apk52+3eiLdqzIORvoNBlJ
 j/h8BkTeCBLLy249sHkAntifsJKEZnC910TcGC45h34i4Ov6CD6tisdEPgMa2S6z44iFW
 yTDRBtZLrBuGZyA7lLxKs975IKjmOdmEj9VMmLl9grMbJ/y+DdZgK8NNuuzYRubiyrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789532197;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=NB07BdvMZ+ShOFZP79O7U/BTpltEis6lsg14/uCWzrA=;
 b=Gq5bOEJcqDcn6IOe0TdyaKrzK1tvUONugTsk7y/4AZ6eeo18eGkFUAv5yM+vylwd+aey
 nLqCzfTMisub2JRXHxa3Oe3tpxorhWtRC2QQU5xuOpyenibJ62ONM6mWUWsHfbgwByeVd
 9gy8ZoF41zSHmqP5h6snHyqJ+6mz4q3GRy6trmQoN2DruuvfnToyK/VjTtwRdYz3oqLgM
 +sjIEVtOQXKclJ3gGK2jrQ/fkacA3FB/7QMJ4BLEqAuppnB/N6iunULtOVIetcEMvS2xl
 alSnLGxH7YQ6E+BJdSmh2kR0J8YBJQ7g4rfdH7UJ4seIBKPw4GWF916QMUh2yIDwEzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hEu9GGYr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hEu9GGYr
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E767B405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:36 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so370929a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789532195; x=1790136995;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NB07BdvMZ+ShOFZP79O7U/BTpltEis6lsg14/uCWzrA=;
 b=hEu9GGYr8yq/R6tpRAzYjDLbxvs2t7yVgsFUtxoFKtsR2huywMiCdaQ31mrFB3sixO
 kEb6fiHEsX4ZejQgzFFssOQFKdBNSZX/2/Uengk1spJeih/DcnWsEi28nQEta0Z7jRF8
 ADO7akQFuWFfFMlkQAEDrOMtds+HssGHEml/gDSLWNpivxM2Nn9fAh5gVCYy+FVS7LaL
 M3+2UA4wr7Kk46U895WzCnLzRErPyWCBJFW3ZDwZseqyvlGVoGlGY9VHxFjuSt806+cq
 hBjSx2KIM0lbG/wn/zwSIDweXJ2z4eten8ufX+J+ZTsmoriOqwdCq6aJZ+Av/QrBVMcX
 B8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789532195; x=1790136995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NB07BdvMZ+ShOFZP79O7U/BTpltEis6lsg14/uCWzrA=;
 b=viqKf2vMovaOSdxoM8Nt5ZuYLMGwFFOPW86xckqMExu6PL4TJceA1mphMzEr2ioOzR
 +y0W0bPa9MVcu8Z3ZMOCLPgcv9d65FyGJaptniCv0os8VS5fDICM/ErIcnXFfJ/bGx7N
 RRF+hSLlKMFvjUP0FSErjwgn1teYDnNxB9wqcqyro5DUls+xiMZZOGhgfefKTdVFqKXm
 k/zxKOG4hfw2huw0G2HUSJjG41H17cx2kMzPlmQRp4KSV7Cs2ZM48X61nrq18nzd+L7O
 gkhLVmBlCNGIcTt1on+nEUY97IOxdPkBPq2iq/D1ZW0fgjYSnhwru7srd4PQSGoxbVkL
 6poA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4xaZ1tpWYflvQE4+qekURsQdROgLePH9CabEAKZZnt7gU55aP9tSK2G4b92y+mBgqwjL/hdE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ku2/bdER6qm7gMGYhBarzyijbsNajyc10/3PhNgk+F0I0fAqcM
 DmuUMr2SgFPWLXQbhw6jynMdvspW95be6soaRR/MLV/cjV61n007n6oV
X-Gm-Gg: AYBFou2dR7cG6sc86TG5Kxw+K7Bcr2bNfhYgRziWZ9hdgtfzb723DK2bWruo66R1gXE
 oR1lrMCJQYptfDZur3GeITnbtJN7IPZv06B2mLVRDGoIx0t6G8RhXVG0dFwT24ZunQ3ubgJ61W5
 FoCTpn5XKY1WQ0NXH7uwzJOZ+7uLA6AKyuIc7fRlY+Gda8TB1x5N/9fr9ywjF7w29XtpwVsiqAA
 MZ5V3wtNUFJdoPmF+/DB+L7pHk5LMlFpTvNB4f8BayBz4VwJwrPlkaiHWUU9ToiGXhJFqlBJ01i
 JysdOb+ETRCcO1iYTta+1xRio68ko/rV01HzW3rPkRXhOTMH3rwV13ty0kMf4lHd+/2li2lxnqC
 2BDnWkCi3VqjGMUOmRvcdj0Mj0rOag8Tmf+HXNrrc+2LQEI0cT/9cb91EXB1pCa5lP+bx7wbH0m
 ucIqri+omO9v6O1zOj6NLNFb9qWut1ZjRo3BHgHk+Es2tE4uTI/krFF+Uu2ezgAfhWewfQVquw
X-Received: by 2002:a17:90b:2803:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-39e1e324463mr2935564a91.10.1789532195646; 
 Tue, 15 Sep 2026 21:16:35 -0700 (PDT)
Received: from [127.0.0.2] ([2001:448a:40a4:1818:e1b0:e8af:138:39e6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bb234c3sm2051689a91.6.2026.09.15.21.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 21:16:35 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Wed, 16 Sep 2026 04:16:02 +0000
Subject: [PATCH v3 1/3] mach-snapdragon: Carve out reserved memory at init
 for MSM8917
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8917-support-v3-1-35103cb4e01e@gmail.com>
References: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
In-Reply-To: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
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

Certain regions of memory in MSM8917 are marked as 'no-map'. These
regions may cause security violation when included in the standard mapping.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c67..eb0242ef8 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -216,7 +216,8 @@ void enable_caches(void)
 	 * reserved regions as inacessible (PTE_TYPE_FAULT)
 	 */
 	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
-	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0 ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,msm8917") == 0) {
 		carveout_start = get_timer(0);
 		/* Takes ~20-50ms on SDM845 */
 		configure_reserved_memory();

-- 
2.55.0


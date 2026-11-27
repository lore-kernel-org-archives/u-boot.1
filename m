Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B059606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q3k7a1q9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WddD44Mg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC68810ED;
	Fri, 27 Nov 2026 19:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtoPuHVGRJNe; Fri, 27 Nov 2026 19:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17C36810C4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795808924;
	b=EqbTzPepGdr/RKGxoL1f34Dcq7QoObkr2JzLjQclbsK0lIMwtOu4WKoGqNLnjdZjbOIw
	 h4AjvKEIN2Ao8m3oJddSzB2TzkbBB8NuW/PFBozQVf5QPqU6+PTzaCEg4CQKdRD1CPeRf
	 rOAb+fpoKOGPjBO9MRZ+B90TEnEikykoOmSZc62WHXUfW+IArlO8zjVMLwlI3gjyMMLSM
	 WUDbAqnLK4ztgYgkI+YG+cJ1EJZqRf4SHAWsKtnRgkFqTpnZEo8ok7qyB6d5WF22A8V9K
	 7Mz+2e3BypDUvxCApQkZWQHeCvPIMRcqIfxAWbuB+sP8uy7ehnQ/rt3MKw3LpAdsteQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795808924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fHAnzyRXBe0LnA2jqzfkQPNaGlVvtoRs0IlRX9A0I9w=;
	b=joSX62vPGwknN8j85gl2ISiPQSwpslglm2kMWbzVqkPS6uX9xDWD+Z3C1xAMVmgRVnIG
	 FJEexuUEUVTBYuNcrSG+4fxrxwI4LpKNVCM8JxraMbMepTvfwdMcNqLktMv/c68tE88nY
	 9VJ2rMNTP9YBnwflzt1bvak/P17PKhKxxeWRbofhrKhqS1xDrhONDYnHUFKVlJOXASWlh
	 Bf044m+tB9R0lfTjZTehJABsANjiYaWmKrrL6I5euM86MEwbnpD8T16I3+YSeRqDZ7UCG
	 fQfy7+2BkJdjEOLbBJs0eBER+UNrycGz2hd56AH6Q8ua1Y6OPpy6wabheuHS5u7eVWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795808924;
	bh=fHAnzyRXBe0LnA2jqzfkQPNaGlVvtoRs0IlRX9A0I9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3k7a1q9rMDkquCmIrqqYkgZzKVGsfH/xyJN3jo8TbVK1QEXV4TvWnB0oX8WS3/vo
	 UsT/3GTvs2hN1Sdf5B/oCgvL9Nd+tT659fXpFeGZVppSnlpPTHXEVlAVGn+4/wyb3H
	 zLAWQVHnLTpFUXHcNJqSEqw7JDKs+7LeGqbPqcvhbUY9A813bIz5kyhC7bFv5Hr/6/
	 LZ3y8AXTFTxw4RJrTK2w4QO0YKSuKwsSxfOj+GjlAuBtxi+AE1SE+cPKel21rO3GpB
	 q1KuT7MgxTc7x+KuwipLwWI2FczZM1iuOK0GiAHyxFgbR63NAk7d2Yh2bSHvRnQ1xm
	 +ayj3mcagy9bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17C36810C4;
	Fri, 27 Nov 2026 19:48:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 463182FE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3474660D95
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGqwbeOg7-lk for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5712160D8B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WddD44Mg
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5712160D8B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:40 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-3282db206d3so6324592eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795808920; x=1796413720;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHAnzyRXBe0LnA2jqzfkQPNaGlVvtoRs0IlRX9A0I9w=;
 b=WddD44Mgy+/5AnxjbLw/avRt5Bsgt5ucp/OvT74HVv8OWVZyD2M26b2KmrBo6E/glO
 9uDRL51hxSAn8gxdHAyIUTUH1lX5ygRUhS+Bx8xIfdgz3YTMKkqKjsMZnHSB4YAvdl5k
 GzgItFUtHemxnOb/wVr98+YFcbdznKVcRpyVU/f49tCdBLKCYPJCEPHX7uW/jq0KQdRq
 ELOn8n77t+C1ax2b+mpNR6FGp9PFJzyMm0nef5ZGyCNOGauyCgfbSXFpRDYUtwJMGO1U
 pD0KKaJxrNbsdzu1YnxjB48JR+RmqsMuWA3h8umLIIs9YiLjsJvGaw+mjc5Q5hU2BdlX
 FxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808920; x=1796413720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHAnzyRXBe0LnA2jqzfkQPNaGlVvtoRs0IlRX9A0I9w=;
 b=efuqAnBaiPSek4fBTVKnonbmfJBfwV+tDypxYKAnU5MRmFc+skB5LXarWNCu8ilFc7
 BkOhT5HSshoREjZn7Yc0mVYplFCDCKpCfNKx8sqXhA2904PSo95iNuGDdZiqPooElg86
 rHTgremmSRNfCQiWBB/T4Kt53W/LstA/SDNBUMluwj+r+FOWjoR8R4b/WonGT8P0jDVy
 X4QH3JyB09ysiF3tmcg3OqgPJC8VXkc0KNMafZuTul4eajs3B1Lbh3vNOH6dUuVrRLTc
 bRA1X1+z7FLuZxinvAigyYaM6YGVJmtH5VtGiOFBtE15CeH22Tmzo8/EFxpYjGjIe1OQ
 LvDg==
X-Forwarded-Encrypted: i=1;
 AL+hErFzGy4WPpCJQNuZ+Qto/H3Hxe1W6CQBdlLGmCXKiGMX5vSdmlpNgaDzH3FPu6R8G3uM2f+N7jA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8d1IXoJfgUaSMXVo9e433YjXqysbzySoPsTV40WxIEpvIYEscV
 bhhmEm+zny8A6hAxbChep+4e7L0yY2UprBDQ6OTZe6lk+tbnXh3v9kqY
X-Gm-Gg: AZFdTZdA7UYC0ZZVb+B94/HO4HvnH+XOMCIs6Ho+Eb/j0SY8oiqYbsxRMAF6thiar1i
 e7Xr6IayTcG2/Tl2dSBpuzY5GhSZ5LQ5oLrzr6RvwLIRBO1A7yckdONTxD1PGp2KoHeaWOdnHis
 sPgh3UyXepS0mm+YL+Q0ayttRPR8ejNRiwTDcUW3fruJ+np++luU994DbpW20EDlYeYaaFIwEjG
 6W67lvOYLeG72+AY5JrIad0tU2G8uoglDMuPASJQt/EJ4pX0CW4x94U0f/73IOTREc191wAqcGp
 SW9YaumbhhnK95kYCgrlnv4no8uvA9LA061HGLXcURp/lmGifOfFH4O8oRtq07wrEu2YkROyz+B
 UEaz3ynJ69pDWuLbZ3fsJqzOSiMhZXbOxvW9A0GRQEUbzPSQ3BCH46vlLNEPYPuIvtLYD9oJpop
 YmFKObTkASYmEGLdx5PShJmgDbN72KhqGSCRp3q3ni08uW8PGDqH0oD210wRQ8yppFEqdOGDbps
 c5bXnhGrg+1xUDJoFDHHARxtQCZ/gXmIbGLC51cC5no3Kyzhapf7HxT89XE1kCMLKUziXrMxjhF
 bWZ+CvXW4FImHR8/p3SajsdWuObPUijyBx0=
X-Received: by 2002:a05:7301:4209:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-3857054b988mr27774554eec.39.1795808919999; 
 Fri, 27 Nov 2026 11:48:39 -0800 (PST)
Received: from [192.168.0.102] ([103.94.107.232])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm84893422eec.26.2026.11.27.11.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:48:39 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Fri, 27 Nov 2026 19:48:15 +0000
Subject: [PATCH 2/2] configs: qcom_defconfig: enable RPM regulator driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-qcom-rpm-regulator-v1-2-c150ea719275@gmail.com>
References: <20261127-qcom-rpm-regulator-v1-0-c150ea719275@gmail.com>
In-Reply-To: <20261127-qcom-rpm-regulator-v1-0-c150ea719275@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795808901; l=577;
 i=nathbappai@gmail.com; s=20260718; h=from:subject:message-id;
 bh=BVT8yKG32XcBgH8TGibgMqiYh5nmoERXX33HN+WseE4=;
 b=hWzCHKOdq0SNKv7IqwihcRovj8K33LP2Kzj0doaVAFTeWbPsz4gtrCGdssqq4C0k029gyna8m
 n4pQDru3Td+DfUXD6PDDU9Yvx/s5ooVhBbcif5VAWX5YoDqHeD9NqQB
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=ATtK28d7wNTkFPtwgWLEaJ1T7ikcnGabljPw7CKsQ0Q=
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

Enable RPM regulators by-default for Qualcomm SoCs.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7945ede5bb69..76da01eddec3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -127,6 +127,7 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_MSM=y
 CONFIG_SCSI=y

-- 
2.56.1


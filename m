Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30997C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D80D34072C;
	Sat, 12 Sep 2026 13:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ltzd29RzfqJw; Sat, 12 Sep 2026 13:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EDB28407E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219640;
	b=m3lya3Ci4rQCndbrhACmK84Y6R5wBYT2Zc5oSOJsTxwdq6T4aZmbLJC+yhz+ADhVvDqV
	 DtIOBpyW6XKvDtSE5KQ/pwwn4AI/Tzpwf1gfYvwuuhh297EfgZzW1GSWW4TEtMrp8UQen
	 /PYXAsxf7ZItyrTouJ97zMN67wEBq/goC/EGgRQ98Pc0YU9rtHEyy7kDy1c42P+ZerPI3
	 tPIswKCre2hTYl2qFxjiYdmrj8qtWq60zF7TYgkT/L/GArjDrBdrBjmAFZjEm0PW36t0t
	 9tHBTLyCIG+XhSiFHIMKclsMNt550QE8joyse4zICT3RDN5vFzB5Xlf5gOJfV/Mdneg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VzInvWjgaAH6s1zPgZZ5EVRzyS7xC9FMju/6IQ2BzFc=;
	b=NFUMlXutlhLOJXoFwRI65j5XUbo9Tpg8B3oLMjahNJKH6lSTSy0UHGTHvCp4BZlxGG1q
	 yMnbzXzXrA0nGUcEZI2XyVOqp4U61Qf1ZbCU5oVkCuLx0X059JPYNQXeSA+TbJ3yFMVHx
	 C4sgLPAL+qsPk93XSdOZ44Vo01pB/GjHVm0uvBylKLESwj02jX4mqjMnOyUUr587Jx4mn
	 WA++sAGCW35de5I0nPA9iDW2rJ5zuYh5Er3SJUllk51+ZOhskdVVKK/xiEE34vqL9f65S
	 bISzQN4Old9UWjv0skXhYHqexv8o/VBSQ2Ytj+2sSwJfFtuh7K9GIzooCxDCggFno2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219640;
	bh=VzInvWjgaAH6s1zPgZZ5EVRzyS7xC9FMju/6IQ2BzFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=baEwTi/jchEuwWsu7MyHLp+BnuOMJDFt46K0dwpdInQXTi58TSDn+KXchEEYevXmE
	 XOLSygioX9Lnqo7CBQ2Yf18umZJXDU9TQbREycROarvrFvv0ze5rN8z42+ULVcVJIT
	 soozRIJKdF6TyIwys0TmTBhQVA1dvq3gYfSp1hCNq0CZEG8vd7jh3tK3+H6COzkoHt
	 kOTlT28fsgzzFvAoRce6vL+zin+LFBa0kVZ5MxlTlauHFAQ0CE2EBWu0+2A4bHmkdi
	 +BN3K4Jr4phL0H3X/l8ZCD0oYPa4hqdn2QNvskjK0sG8ui83ROIdwUpvq2xaUkENXO
	 76Aw7RjALSl+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDB28407E2;
	Sat, 12 Sep 2026 13:27:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF9AC3AF
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E15B3400FE
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txDDzZDcKvHp for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 07:27:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4997A40076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789198055;
 b=rCVuQf2rSI88VCa2KPfMRt6PoY4e84Y84S4dP4adbdqMT4bStknLNTj7WFKuBB/7K9z+
 O/EJBsUHRH7/DvLcha+2ixkZDTDseei/Ic9E2vCfLrpClT/Av5vabwqpx4QQLTMSWSY1E
 FFE6H7UTPAqwiclDUg9ZBPYv75jAbD2ReqPq7XGsFX1AnOyVWFTWqq1vW6zU8OFrr3UYn
 RYOJ3YG0a61+FVcYoJxK02UtQxJd20IfEHk7/sWl6a522ujs9EcS721I5mVd75OmVS27A
 E29WgR3q+W0sgMI27/4SlKuorH6dCvuV96TKArz+QidghxPrsACVHAzS+U5Fu0zkZbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789198055;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VzInvWjgaAH6s1zPgZZ5EVRzyS7xC9FMju/6IQ2BzFc=;
 b=Ij9HtT0jld0ywT+20RDaPZ8vxWSt6rLHh0nJf1W00eQAskWZLsuH6E0IDvWw7CRJtjFr
 hRS7MTxqbpRLFgN7xUJ7bFBWwFWDJlueKz4AehFPnLUvU6nwFUOQ6SCcxQZNvW0JV2m+E
 PBTSNOoI1JAaBp+QqSDk4fB9+HPV0gxiLfxEXINP4cJ6h+s1j2hjxFrZrSVWRTJJiE0vK
 XjJ+4sL+ibGXpXfgKkS/UGeq8RHrOziwPsNVs1Hm8KB4O4mC1DhM3+JqsZTyfAcSxmJOr
 7UCAbhbHO3WBo/0Q3ALDK9jCJIKpoqvlvkEyvSOwcDDmX9v53WElLwt8kRxqTl3apAQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SDhqwn0Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SDhqwn0Q
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4997A40076
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:34 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2caced6038eso17786205ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789198054; x=1789802854;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VzInvWjgaAH6s1zPgZZ5EVRzyS7xC9FMju/6IQ2BzFc=;
 b=SDhqwn0QrjvgEoo9FcESa6WwtYTiAFuM4dzwN7frkRgQdRL9QnuiE8bDEwq5d0zUAt
 KZdsllLrvu6haMYWq9m3vL0dO1okosnzp4ppaUVziYqGJDWOjF1HeZYNWSakrM51LoMD
 +593NVrC82Mknp0kDnPowfy95uDV0dtqAg0jqcfrNvfHb5sQijVlFxkTWhZRs2JPWzYt
 TxOiAxb2LIiXQ7nZTcN0f06uUM0GBJ5jkDEblCq8nKJoP+6L/Vtr4NSY91obXeL3bGPX
 Yi+JCTeHygH1TxUGd33eq7MazmR0YYIEjhlNg4fWzOty6zyfBRo29oVQ07niaheoDjir
 1TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789198054; x=1789802854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VzInvWjgaAH6s1zPgZZ5EVRzyS7xC9FMju/6IQ2BzFc=;
 b=gVDLE7XgPC0Q+yoqnKjh9JHPlS1JIbo5MsIqvyFA6XX2wkUskG6LrK/uA45ynrD82+
 JN3J921W9Eq+eq0cKJhSgUbs1KpKRWUq3ERBPWvDmhtWqIZc6GIVgCndBmXvnR2uGEuv
 cPk2JIbgZ+r8VuSWo/pHPj5HCgz+edpEiPo1iDgRxEdFOj33K5MOaMm9NECcutP5q71M
 RWrQSpF+4Dw8gnJyGwWkVRPVWLnOAYpBDEWRQfTNDYuMNF68DHGz/EmLu7kmEHLhssIE
 E2YrNBYe37iCF4Yqn2CIYTPhuTPtOs7ChsUSpoWl6IC+CcKpp/MGRGAaT5JG9A4Ben/W
 jAHg==
X-Gm-Message-State: AFuF++kfYHxqokBENNE3E9AHN+sackU7TPdM4PMG3oTpVGLLokGVY30Y
 MhRKuQLDibcJgs6NXa7f0zQqnc7+lz7zVWMmveDdZwuJXCM2Kr4yXQEHaogKtQ==
X-Gm-Gg: AYBFou3WP9eym6neeAY27bpShAn+siCEZOE2jduv8fqsee6fZ5TDrx+mAxLpVrQE+hY
 asJl7jzo4m3UTmyws9zB5W5OxL2sms/lfulw/zz2iPM5RkRdKmyC1oVAohkARdv2cfSE2kIdq9v
 ixEt+8QVn8ZJX1YZnxaMGzxg88rEZ3hgycHGQQRXD38D5iNpOKybdZFImFdlOQG2fZQCrE9oOW6
 9CWtPc6ubgici0SNKzJDpVQY0G5ucctWQF87sEwGi4JX1kq1f+eMzwA2K6ImsEP0W3Js3n2z2VO
 5gL4AHP9HSgfr2WNKgpJhL/GW9R+A/KD0vOd7YcqyrHVW4e2kKxcQmw4VtsOHhJcJzYu7VZiEN6
 CiSqUNL/zi+vcDqmuwtYPxZWNIHZxE7GR1soyPSmnaZWtnlx7R85FIug21ae2Wno1zziMB2rhq4
 3xcz8Vhd8bOtBh4rvJQPRHVdKwj4qWOKY2/gzHis/QkRswjuejZlsA62OcOEeqYA==
X-Received: by 2002:a17:902:e74d:b0:2d7:1b20:e98f with SMTP id
 d9443c01a7336-2dd0e8a1969mr135962575ad.2.1789198054012; 
 Sat, 12 Sep 2026 00:27:34 -0700 (PDT)
Received: from thefoxflat ([2404:c0:701d:4e35:a09e:399b:32ec:61ae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfd719dsm21469235ad.59.2026.09.12.00.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:27:33 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 1/4] mach-snapdragon: Carve out reserved memory at init for
 MSM8917
Date: Sat, 12 Sep 2026 07:23:05 +0000
Message-ID: <20260912072619.244101-3-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912072619.244101-2-imkyufie@gmail.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
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

(no changes since v1)

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


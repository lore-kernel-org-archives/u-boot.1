Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC49606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0dy/ZRed;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYVnFy0M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kZAIvS/b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F38B81337;
	Sat,  7 Nov 2026 02:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPnvv37sknuU; Sat,  7 Nov 2026 02:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C77181375
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794017175;
	b=g5s2o2w5pdn3Ux9Vg+GMDVZYG6xPorhM05yM7nG3OxdTKhgI0+CP5pSnzxVz6LmjD/UC
	 j53fFwjn0sROY2vt7vV6YudF8CUMI3L/7cA/wpcWq3C0tRevaCPEKGM2L0kxTBksjpcHI
	 e9lQOUzlIIgAo1hsm+EL0CT8Hfe8L3nYXnShshXtcY1MoEd69BwGqz9cnko/rCVGVbRWP
	 apVorUHOZLa1mK1ILoSJNqApJ1t/lAzfUVjipv4L6564TyrS4XLGBi9haL2U5c7bDrfLA
	 Qc/FovXYs/+HYShi2vZVfM+fuMtFcpUio/POZeNfEIFOeF2VbRN67wWfA+4ABpNgf0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794017175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RK080bsJs+aFQBeP5tijMy/Ct8yBUmzs9BY8rTexf9Q=;
	b=QGuCoEkNJX9YmViU9POgIp8GOkwzb9MHqvOBPnyGdi+qHOq7pDTRJuL53eqyqZoeIhqT
	 nH1Aa/4Rt6/C8BpY2uxR72DGrSjKeT7dh1F/oQ+EQXZJ9o7Wpjrc6MLm1IsDHZrISsqT2
	 QX8kXmPOK9FTdtBiFXomlrDZwyGBX8B5KpTdibUJgsVphHNkNQOq/kbJHgLQDeWHwxkK3
	 kpfodZRR9we9XRq317JXb31EDaaP0G+kTViaJrIb5xlr8BHRb9xSlJrqqPyDMovK6j2xg
	 BxFZik+8e+2MAOHZJLvk3Otl5SYpozeqpO0hLyQ3xF/1twKr1ZxUkcXllbF3CiM3JqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794017175;
	bh=RK080bsJs+aFQBeP5tijMy/Ct8yBUmzs9BY8rTexf9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0dy/ZRedAlUYu3zz+N57e6lx+ScGZxeBxfghqOFL1YrcPf8k5J46yqoARI5oRn9oR
	 IUXnhKwmc5H7Yvp3b+b82lkFwdC1pETvRgXuR3gHoe0VEXW7YIgOI0+bAFUWx5ZZJa
	 wHaNKeN36crsSwr7cKY0xcZizXGFhN8TpiF3xkcW5L/bSzE+NDHx0zAl538bI9iKAk
	 Vzv2Rk0obq524nhQ47fg/0kj1hAnHj50DJzif4nYiQ51OGnT/RvBC0aw8oEo8oWCbC
	 f9vt+SVAmVG1uGyLvfWlQwE3YoeF5fGRVZAmmwtE2a9GoHcEGhWfTs0AAAuRAoWuNh
	 8WtZdA5+b5xTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C77181375;
	Sat,  7 Nov 2026 02:06:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE7AD34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF64B607F7
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r887Abt2s9BG for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 02:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97487606EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mYVnFy0M; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kZAIvS/b
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97487606EB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoO2v766818
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 02:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RK080bsJs+a
 FQBeP5tijMy/Ct8yBUmzs9BY8rTexf9Q=; b=mYVnFy0MDn7R17L9euuv4ZPf4TV
 v6gl2jIO7Z4H/BawvGzi7IIbQlaj2WDI7R3XAosLQVti9o+i7hvYLQm5X1sGR+Q2
 97eUnfiDLj0mCy3bFIp0pAEWSXjg2uTfPi2FkFLEOjEbBkFuL8maNy7TjmOdcO/f
 UCJ4kNuKm9WdvOQfngPRxA3cMqJ4fZGIKevwqFe4BWIKoTYQutoGdKiQ11RbRcEI
 33+HuBhDoi+gM553JLJ9l64G5cBGkP1/SVPjpPNUCzEJQt7mhMQOxWbasdgz3rFL
 7m7Ms4H/xe71zCW0E5ptsm+WX7S7aQZO00HE5RJx2Vb4XvtZSRsFFXDr1KQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48smc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 02:06:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36fa5673fccso2789312eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 18:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794017169; x=1794621969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RK080bsJs+aFQBeP5tijMy/Ct8yBUmzs9BY8rTexf9Q=;
 b=kZAIvS/blJsRS1BPBroOy0VbvCoNKRL5hs416CRn0Zi8myBmIypixVAmuOUisFJTOP
 mwBWu7WcJSu9qHBoVXwRJA3+Wk5MF2HyKPjBPvJuBPeKpN4gGLMeCeDDPaukpLaOgpTa
 MZHSqexMoHsb0qcl0femIntZqallzXsJ/knASyLjzciI93+YB5RaNFWfVyvormKLympN
 BWh3ok4t4ELvsELUO8d/YJbbSlzgJRhjn2iBYAAqyYfT8hTqF6XpGhFyPYLQBsIS2Qy6
 TJFbmlxJmc242WgssQjPA82gC56wFNNUQR6F/CYLCopMve4oPJqRLAK8l6mZsJexepUf
 SS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794017169; x=1794621969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RK080bsJs+aFQBeP5tijMy/Ct8yBUmzs9BY8rTexf9Q=;
 b=PPp/jPPHIc5598F+c0LP0kU+ju/PHJxNr4D1FGdbelRhKxKk1Ay1cfK6O28yqLJqkl
 0HlRg/JEh6c4Vb284bR34++6BeyLvzc+oMDQX8cwyHCHaMX03O3ke0rDs0w8qsGJ1DSh
 gP/hmPvFJgjknHY8AxnFgBURMKQN0PMG/A5BicMkTRMsfXc0KTSIgn5P8euzWyEVJnoJ
 uXMyZzd2NfEGsqCQbJ8zFbexDxvZvHPjL+JS74xLrAmmF1FMjFqUvo50G4iKxedY9rVP
 X3AvzJgIpB9CRUr+DXxxJiX1ot1U1QNO5NUthRe5Z8MZjAS/URVyS75+tIt5zOsk9SaO
 W86Q==
X-Gm-Message-State: APuU4Z/cThRwiCQWCzV0R57Km19LWRUZcWI/HrewGkaxuDCGaJ2f6DNy
 68YI6X3VqEFcxq8AIopfrWraRNiEcqacKs2owqFYjW5zHBzf343+gArsf0dWHYgIR6VDQTkuTF6
 j5Zz5yRJFgk/ywMouqRIUYqCCKuJxTN6PSI19CPprXxRQ0XvoGhqltbI64v8YQL8g9bNecMfa+U
 sBjeY=
X-Gm-Gg: AYBFou0/uKUVsC7/nbbbp65UKAT7Bgu9FiFiBbz8L6YC3gOy2KPGCG4/ruMS3uFAY7Q
 /vIxj8rWjCQZzry2dmTaHF3sNqwm0CAPNXkBiCpkIoMa4rTqb4NE1gYHBApT9wrSCMmOwX5fySA
 /pIJhoEmqWKDoAcmqwk2C28TklaSMe5QN+z/Pdr5OW6HgqhSrhroV+5WPnFFaDvBSBdKedKnj6k
 DhELFB0LGUDe7JFIOLOa81EaFIsdUx/7Dk3TlsLCD5H1gLaZ58eGQRlPy/TkZ9tn0DByL9MNcYE
 HdrgtSUMC9woZF7v75jiqDnV9jCxMfbpXla/1DgN4pU7h/yu1DA+0t0+naPFImRyX+7mwXVrt0Q
 /a61DWnUZDCjwkfdZLO2PHfvUAQGFJ2XUDEiFW2dgc1qU9zmoLzzCr6gUlpRs55MXTEq0r3obFx
 k+aKyBdFAOK6Ks24EZzY9v6hZpP62thQ==
X-Received: by 2002:a05:7300:8245:b0:36d:25e:1961 with SMTP id
 5a478bee46e88-36f76c16096mr5703067eec.22.1794017168812; 
 Fri, 06 Nov 2026 18:06:08 -0800 (PST)
X-Received: by 2002:a05:7300:8245:b0:36d:25e:1961 with SMTP id
 5a478bee46e88-36f76c16096mr5703037eec.22.1794017168288; 
 Fri, 06 Nov 2026 18:06:08 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8d44500sm10922798eec.5.2026.11.06.18.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 18:06:07 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, rick@andestech.com, ycliang@andestech.com,
 e@freeshell.de
Subject: [PATCH v3 2/2] spl: Add BOOT_DEVICE_UFS
Date: Fri,  6 Nov 2026 18:05:47 -0800
Message-Id: <20261107020547.2021618-3-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
References: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfX/uCQamlEFMLB
 KlJaTP90ofsf5kQbzZIa15L1EiPie42e0ut39Q37x25SydNkjBipIfquKWiBe5JCn1qLhkKMf9F
 21HuMhj/MTduUmkOyuFZC9iaDyZZaMJZ3alUZ8yv8QPD4N4L1lmUe+HLw+6NdqzR7TJ2N8X1SNb
 o6ufxdz8MQ4j7naVZ+IpWLpBUDAh2mfbYC7LadImbjKmFH7d/K7Jb4ABxd0CGOcsXX1Z+waGzb4
 o1yDjju3Agt9UidatWHD8jfuX3yw33/vWD4JngIAGNa9jcW7UYNY0yMOWunDMGYj077QJwKyd8G
 tif73px5c8QuWSgz4zBwJiwLu4M34oK83vSt0hpkV47Okn7dvVEnWZlUQHSG+CgDxfGG+rKqu+B
 qyElXnjlN6ZN+PtnRWdE2KV3VkdSxo8wzzHXsrjL1Ac+fp6KX1ihMqebu9nCetxvTAS7FsVvSwD
 yQOey+XYszc08MUYytg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfXzMiQihTmJnmD
 7nV1UcfkJnHRNZclofW3FK9LUWkKozx3SEvz8s9Ybu228cGZZ9lXS6WQSkoMl04qPQcIrPSRrus
 NB4XMnb9FlvOcFMYEdA1o8nhJnHAoKg=
X-Proofpoint-ORIG-GUID: JsOXdpgVoyepml4VLKPeN6sQ2GynZfex
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee8792 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=F-dz-mXkbKPbmbHUq4YA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: JsOXdpgVoyepml4VLKPeN6sQ2GynZfex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070008
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

common/spl/spl_ufs.c uses BOOT_DEVICE_UFS, which the common list does
not define, so enabling CONFIG_SPL_UFS_SUPPORT on RISC-V fails to build:

  common/spl/spl_ufs.c:49:33: error: 'BOOT_DEVICE_UFS' undeclared here
  (not in a function); did you mean 'BOOT_DEVICE_DFU'?

Add it before BOOT_DEVICE_NONE, which stays last as the list terminator.
The BOOT_DEVICE_* values are SPL-internal and are not passed to the next
stage, so this is not an ABI change.

Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
---
 include/asm-generic/spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/spl.h b/include/asm-generic/spl.h
index 7b4789596a2..5b50ae2acf3 100644
--- a/include/asm-generic/spl.h
+++ b/include/asm-generic/spl.h
@@ -31,6 +31,7 @@ enum {
 	BOOT_DEVICE_XIP,
 	BOOT_DEVICE_BOOTROM,
 	BOOT_DEVICE_SMH,
+	BOOT_DEVICE_UFS,
 	BOOT_DEVICE_NONE
 };
 
-- 
2.34.1


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F5606A335
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yHvDUEnJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ASIGUP26;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G5QH5ivf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 797D280A84;
	Wed,  4 Nov 2026 16:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBXtfCv9cbeK; Wed,  4 Nov 2026 16:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0F26808AE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810070;
	b=LQPKqmWvigy2+y2brB+egI5UDnFQRu03HMETxphSYY7atgFolHOKolqOudbqVXh+hQbG
	 yecc0hyfo5mGXmQmbrejtdrgHaA0LEaW/YfpO3dVFH0FDHrQ/7ZpAl8zT0F86MDcBR2zu
	 19V3wSodU3ygeGHQyMCxqRNOz7iy7C5AMENOwbrHJlpZxJVKAIpeTf/NAIkMag3yfwIE4
	 +Kl6K22VcmuzueWPitkmJlpFuyvBYz9DKLGAIlMrA7UDOQivh3v+C5vE8mfwOK5Pi/UI7
	 1Konq0awpzOvMcf38IX6jt7kI+e1EDENuJuLew/J9zEDA80XyvwMBHPvkS4j4ZpyPRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AA95za2KcH081rcVnK9hbeLuewInaQpf7H1b6ifxYKk=;
	b=bWMuu0Nvfszro2xzSjcE265s6jnaI4wz4SAZLc7EVN4iUT/jXnxqH+cG9ANhq8p4sbC8
	 /XJqiyDOM4JdVnH7tx4wNbW6bLcmHXOKgAd2xkEiEkZYjrJfHtSQrbyddntFAiz3+K74n
	 S2NztY92AnMUwFjY/EhmpUKB1c1KRuTiO+7vksQa1EfbLUHTbFxDDfY+LfG1UU+R3Mh4N
	 fjzDXZmzyhtQB1ZvqMFNVdi5q47zC/3TlSsYLXqp7ACCy+zzPmeBZmw3ImlFRZ53LjhT1
	 bOo3TP0o/BI8YBDcro0OZUkz4Rw/3vetv3uZjTlzr+KIgCMJI8KZ5f6U1N1KdkuKFJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810070;
	bh=AA95za2KcH081rcVnK9hbeLuewInaQpf7H1b6ifxYKk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yHvDUEnJRWRFCygERMaZ3SwWNDBWAB1863df56irclvMRf1Vuk2ghpaguIa8j7SUG
	 AR3gkVcbT02YcDTbFINqaGMyQdAymWS0DYluK2N8VqC/jD8K5GNj2oAbnBcLd2gFJv
	 zQMfeQ1N0NH4Wfu8U/S16UWmrWJhHFvk216L+VP4ezUhxRWohHxCp5UIPdhFwHyTjn
	 OZuvdVW/pwliOD2iJv7w/paqt1cc5J9S4lDGQOWz5wtjDUyQQ7nWXoPCceDGYXDCPN
	 XZGLqqvRzBXgLY79J/nDvwBXIkAFKLmjpLTDLkizgSkaWg8TwUIJBIh/Ub80LwHA0s
	 Rgfy08ov4bMhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0F26808AE;
	Wed,  4 Nov 2026 16:34:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCACDA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EF4A402D2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HX42VYsUdp9y for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9A3540310
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ASIGUP26; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G5QH5ivf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9A3540310
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiqbL1292233
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=AA95za2KcH081rcVnK9hbeLuewInaQpf7H1
 b6ifxYKk=; b=ASIGUP262fMinCv1MENRruOonmI87bP1ybNfu1hpmHPAa6EFvK7
 mUvzn5nHtmrZ9cJXZbzV5Sta0Zqn8C/rdInsw6ymcf9Xi3QOCzips48NhgDhyK3G
 p5t5kyx6aAZiaeteD9yaRpQjJRmFDtkRCVqRm5t+1hxRYVsfXvuZ5b9I/OiSQddu
 Hf88q+q/wnvvnuRYFe1GHv/ufsnITZByMU7GH8fVJd/UKR3CvyZizaQg77QqW5ii
 vpfaGuUISWSy0Q4SFIXZ9Obzy4XPyLkQ9WAoIjZWeAfNb3Cmmd6PRA+jDmBFm+Y3
 KOQoOeEs5iHElFX1wlp+kDPkZvE85jQ4alw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hx18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:34:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36998507c13so1014669eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810064; x=1794414864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AA95za2KcH081rcVnK9hbeLuewInaQpf7H1b6ifxYKk=;
 b=G5QH5ivfHlbecqAj5uEGgMb2Se3jyI48dI3D07zzURuuKXNkM34adzMAhS0yhm63pp
 +IEBFw4SBDEiLNFoKHhVBPGWfdMjYPwu17L1c8j+dtIammr8Bb0HqtqpEiW5XE0Rz/T4
 OUCU2RiL1+NRIKUU0ER4qGoj0nfLARVWoFLuTQ2wu7NC7qT9kxS/FIuZql7Utygsfmzz
 N2SXlmWsjaVJmUBgaYKpn0LqkoP94sIt77WXEDswK+jIlnlfmQoIXCAAmdl6SqB36FY9
 Drr32870W7/GWqNBT4PoKnRv7Nz/CgmCxfxow2P9aQWglUvYerrcZAwych1pVDjDA3Qj
 raXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810064; x=1794414864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AA95za2KcH081rcVnK9hbeLuewInaQpf7H1b6ifxYKk=;
 b=dupOnEr4H+zocA/ZofT+2pMOfmRrnQaaS6z7hYHOe6S19tE/xCEj5Qf30IwwKqDpsz
 DnMsYTEsHmak9X8axrFJIaebzXOHFTcLCpH+UAJc9WTYrKtbqICEyWMGbpg+ECIUohyj
 j3jR9Zk9DENKBqaAiEicx6BVengJ9mKJ/bZCOPj4MYLa1IaeIy2QCzyVfesjwMD1Lc5S
 RzW1BW/eU4K7iT0vQdjmv8psi8GeILDqiLq99fxyc1uWsMa8L8TnZKHXXLP8uLhsMcke
 kdWtu73QE69NfQNQRU3uqv29Euh7VENlhWxgSkWd6Gnu3kB6j8/GgwM3r69Ix/4Gb8mC
 nUZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSGULm5u/XwZUAbnG3JJ6G7tkNcC8fAhMBtmbZPwsJF1jDPbgMojIXq6LvOMkUflrr/b1Hov8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kvYiiTnt5BIAzbvUOhOT5VOnqiIezaOR1tC8xSg+Whfsf/xbC
 SWmOyEVP0dFw+ARwJiXlYqekVnSWtKRaf2rwHYLEKFnmk2h5WqfwgkOY1W/ZhDQZXI/ZXD8hPhX
 CJt3jGGfVRNucDBjdPXk0KPmOhujzsdYZVlHXO+QmR0sVzvEvnIY8Dkky7wtROjU419VMGOM=
X-Gm-Gg: AYBFou1Eb1sx1vpAAv3YE+8BzLFU4jy8lNyzF5kD9p/QCDuYm5NUZzMWIdzufDhSfi8
 l+4R+agI2qyQEJHXc492w7rwuFGlSb38BjCr5J6MUZ0dU8slYs+Lz70DgTVZ7XvfNmLeuorme+y
 0nHuq5tO9UZ+kJACQ9mU3MVOnDIU72zBLYy0vmuB4d6ebPE5VFWRvGsrrrdrwU2pYrfwPGvT7tG
 fh82O4uHdNU3CkzXT0V3nJiGo/lW7IhrfnvkuexUbqrs7a420sd0xdtnl+Sb6gfwU5KMT+poxMp
 x851W+KuAT5QZxti64uWaz+fSJO76uj4blkZXLzTMJK2xE/nv2FJWmgBIIrYnOiDPZ3Q6VFAO7z
 1b2Gjhw8caazl1RrWfy4CYMBujb8OsZtpw4AkcpzGQGOVbcXebhkLMQjXjjDmVKfJk959tiucBf
 W2dhw91OLnZBUlMGxmv4XSMwOMdSW29Vw0KgLD1TFGVzvFuTOfeHyndYOxZi1+5uQt
X-Received: by 2002:a05:7301:6187:10b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-36a4242f5c3mr25356433eec.16.1793810064203; 
 Wed, 04 Nov 2026 08:34:24 -0800 (PST)
X-Received: by 2002:a05:7301:6187:10b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-36a4242f5c3mr25356382eec.16.1793810063481; 
 Wed, 04 Nov 2026 08:34:23 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:22 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/9] Enable PCIe1 xHCI on Qualcomm QCS6490 RB3 Gen2
Date: Wed,  4 Nov 2026 22:03:49 +0530
Message-ID: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2cxMdPNrGs8lTDTzblf1oE6oKOe2YhUF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX4pQ/JbRjmXEb
 X2r5bO5sz9cpO+qqJJp5Z2qOHf2Zm/tpuzApjusDLN+3Zstd3kDrTjyd7GRj64ZuN0n7sAcx145
 p+XtmRSrHps4Hul301PdXNexDN4GLE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfXxFf3VeS9F+ka
 I9IEBCyE2egEjXX221DGPnBc8oMA7id/Pl/rABo0qf/TKZHoNE1aWDi/LKpYGEaY1v6h1biRSZA
 SvqJTBbuKBQEKqKJrQ4Q4NSWvEPP8wOQNB1vkNBZ50a/waqJ7/0dluMHD4IipZi9JFhZVtagtkp
 x39zreWJJF3Ykn7JVHSTCxQMgJq266gCIdJetjtUGAudguqRw6nAKZWUCYuuZ0iH7fVRApXirC0
 qMoXfVCzFdncjJu3WScZDa26/5UZ2bFrViUydLgmUhZNyt7Cf3spXdQtwlZvOXT94GAaduZdB30
 zXip4Mu9si7YDMEM0ZY9lQbj2AtJPVkgJAwTbqDo1R4IYFm37EU3b+eKUslFmXp7w3gctOmbBWT
 3wV7vesuc05uhetP/NHChkNhY+l8LKEe7JkDd45GdoPZiwjZea4oz6h02mv4hy22+68PlWfStmE
 zfQ9uQLIamCv3NtKCWg==
X-Proofpoint-GUID: 2cxMdPNrGs8lTDTzblf1oE6oKOe2YhUF
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb5e91 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=BZEFi6TpgDZoxOpVZY0A:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040065
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables PCIe1 (RC1) on the QCS6490/Kodiak RB3 Gen2 so that
the Renesas uPD720201 xHCI controller behind the on-board QPS615 PCIe
switch can be used from U-Boot.

PCIe controller (patches 1-3):
  - Add inbound iATU window support to the DesignWare common code and
    use it in pcie_dw_qcom, sized from "dma-ranges". Without an enabled
    inbound window the RC drops endpoint Memory Read/Write TLPs, which
    shows up as a Completion Timeout at the requester.
  - Program the PARF DBI/ATU base address registers, as Linux does in
    qcom_pcie_configure_dbi_atu_base().

SoC support (patches 4-6):
  - Add a no-op gate for GCC_PCIE_1_PIPE_CLK_SRC on sc7280.
  - Add SM8250/Kodiak Gen3x2 QMP PCIe PHY support.
  - Add the PM7250B GPIO compatible string.

Board and IOMMU (patches 7-9):
  - Sequence the QPS615 switch and xHCI power/reset GPIOs on every boot
    from qcom_board_init(). A static gpio-hog only drives its level once
    and cannot re-assert across a warm reboot, since the PMIC rails stay
    powered.
  - Resolve PCI stream IDs for devices without an ofnode via the
    bridge's iommu-map, and stop qcom-hyp-smmu from disabling stream
    classification at EL2, as firmware turns unclaimed streams into
    FAULT streams regardless of exception level.
  - Enable the PCI, DesignWare/Qualcomm PCIe and QMP PCIe PHY options
    in qcom_defconfig. Also, enable qcom_board_init() override for 
    QCS6490 / RB3 Gen 2 platform in qcm6490_defconfig.

Senthilkumar (9):
  pci: dwc: add inbound ATU window support
  pci: pcie_dw_qcom: configure an inbound iATU window
  pci: pcie_dw_qcom: program PARF DBI/ATU base address registers
  clk: qcom: sc7280: add GCC_PCIE_1_PIPE_CLK_SRC no-op gate
  phy: qcom-qmp-pcie: add SM8250/Kodiak Gen3x2 PHY support
  gpio: qcom_spmi: add pm7250b/pm8350c compatible strings
  arm: mach-snapdragon: add QCS6490 PCIe1 power/reset sequencing
  iommu: add PCI stream-ID resolution for devices without an ofnode
  configs: qcom_defconfig: enable PCIe1 RC/PHY and qcom_board_init
    override for QCS6490

 arch/arm/mach-snapdragon/Kconfig             |   9 +
 arch/arm/mach-snapdragon/Makefile            |   1 +
 arch/arm/mach-snapdragon/qcs6490_pcie_init.c | 178 ++++++++++++++++++
 configs/qcm6490_defconfig                    |   1 +
 configs/qcom_defconfig                       |   7 +
 drivers/clk/qcom/clock-sc7280.c              |   5 +
 drivers/gpio/qcom_spmi_gpio.c                |   1 +
 drivers/iommu/iommu-uclass.c                 |  78 +++++---
 drivers/iommu/qcom-hyp-smmu.c                |  27 +--
 drivers/pci/pcie_dw_common.c                 |  59 ++++++
 drivers/pci/pcie_dw_common.h                 |  23 +++
 drivers/pci/pcie_dw_qcom.c                   |  62 ++++--
 drivers/phy/qcom/phy-qcom-qmp-pcie.c         | 187 ++++++++++++++++++-
 include/dm/device.h                          |   7 +
 14 files changed, 588 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/qcs6490_pcie_init.c


base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
-- 
Best Regards
Sumit Singh Dhami


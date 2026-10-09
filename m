Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF486CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BD7381463;
	Fri,  9 Oct 2026 18:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1LXfZHvopeVy; Fri,  9 Oct 2026 18:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF144813F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569652;
	b=tBimg9n2BQUHbqlSb2UVBa/vBaB6P2kNsf6a3UsLNPSKTz9itQy4uMYzCZVvkizo2IGU
	 K6kuvyxAYN0QZnMI2/5WabBst4LxdeYG+AfIPUyHvh4RWz9VWqzzSNOdpr0ruXiK3Jr+4
	 czwbINUVJE/7E1nVhBe+Kbty3IQm4deC5IBTkHhE6XIrUeVrkmb9Iy46GwLXRg4KWU8UM
	 Wzkqmte6GVrT/SGSo7KCZ2GXHzsFx+WUYLUlMcBKQLeE0tVh4NV+FZMoB3p96hiZFkW1M
	 to3LZWC25enlf54vupx0PWMCqOCW17vvCJpnanvgqUBUk5EDn7zQlzkmQ3vglG2W8QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+x5adTMQLmvfmkakNvmA6/CnniszH0zMIj7lqhdRaFo=;
	b=ChNdVVHz4hQVnjqBB82/81CNHZBKpZmS158hWtcD1rmYN3PxsIo0ftgf4eDdisv/OMnp
	 JAqqQ4PM3EtbewVpnKVi/dyZlg9bh07cHAMjBRJ0XSEcKWWEe5gtd5ZlQAlb+Ip00TYoN
	 h8mq4WLAu4r0QPFvd3FVX4IcJi0L0/swDvOGtWPpw5g72duG5JRA0Duk9LoYz7RsmVr/g
	 21PE+8YblUqsswdoCRZ5INSjvxCNn9m7+WZj3yc3vhQUIXT1T426WVXSjAp1Ajtp21aWo
	 39/QVmBCLvccrSZnX/8oFj61jYcQvwtwunYyzJ5inHe9+++tfHswqT3eem7IRq4rSEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569652;
	bh=+x5adTMQLmvfmkakNvmA6/CnniszH0zMIj7lqhdRaFo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGpNbJHE7N7TJtydkfq8StvT1lRv20DwiQjedW6m0o1bwJGtScsAnrrp3NbA5Xj/k
	 Sei3dNL7sCJPtNYHRaS8iu+SgH0Ico/AYO5X/rzdQg4wBEvpEIsdVC+LzttSH4hjDn
	 sLPfaf1A5zZm4z+xDOeRa4OFUZGyAXFrmr47KLl8vd8CqCgCDIxuDIMqk28DdQuH2S
	 1BbkcfZ2TVyKPUOjTZS93LJPhLQX9g4pndyywtUj3iuaSuOEqMxNrpMRcJWWMop2nJ
	 RJ7u2KIqAv6Z+0IZ1Bj5oE9yzjNmy5Mh8Bq8W5owFe76IFkUEa19abdqUHZkuf3Q9P
	 KVMOrsFcYVb0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF144813F6;
	Fri,  9 Oct 2026 18:14:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D76E380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83DFF408C4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WajlY8xs37lp for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 616DC40963
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569646;
 b=EOiCLUUqEMvRlbCEnnzyHpGzVTSY+EBM6OtPlPGCSvV4oWDrL0dqZekykjO3fdImsjtl
 2Ul8OF30Mhemjvj5ux1fH9pAT6vPlPbCBOiaalgjge1L4rMs4PjE48ZXsBPS40/kMn5Xf
 xjcDg35EOreYn94l8X1zIpvI7dLuKyX6JtbiCayj/4vL4IXl0U96NLoeXte+NDXbhhU2w
 c+p+VzqBfi28MsP9+eGaWEgMph5syu6MXkjKoA0YunU95M4xjGCGIad0JBAn8fvJ93jPx
 ltjmwBhu/3eBQLZLKEVBg3vtwWZJ8eVmBpgHpqsfJEg0kWnUpXEo90ku0gdpT9kwVPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569646;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+x5adTMQLmvfmkakNvmA6/CnniszH0zMIj7lqhdRaFo=;
 b=oiVFZNweycIWw4WJCqTxYEC2TRkduVyTsOnfaW/7JqoxwSpVebnRZ4wGUPVme3c/2yQi
 9VQJofab55Ik8dew7gcW/rAVVkoeH+zXWGAhf+Bh7wgZU9sh98v+RBuKo0e8Ujad069ZW
 xkzPZkIzR+db+ZwjSW7EQuJARdfAeDhAI5JHGxxHkTQfDmNr/CqLV90OQBi/E36nKuuus
 vjfc1EB9nTHk83StuE7ucZizrdaHsgs31peAab3yELbC9E+44gylmS9RDTUvdWnsK71Ti
 MQGbRf3pS5juEZ+RLFmTXGDwCGFsS2uL+XOR/FUeioDquPlbHqWSopwylYvEnG53m9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pN24kTGD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=a3QAV0ae; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pN24kTGD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=a3QAV0ae
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 616DC40963
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZVPH1016055
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+x5adTMQLmv
 fmkakNvmA6/CnniszH0zMIj7lqhdRaFo=; b=pN24kTGDji6tl4UnvocO7dmoenv
 lQO0I8MOEqzKGXZALyvMFzWEaSMbE62m7xBQAVNaYErsK/WpV2WlVIBdzFv/HOVe
 BGS3cnPr+0DbvX3sYuMrzldhPKh0GFwchDSHe2me49Cmx51DdgI6yc5yyG0A9EP4
 2OuiM6dXx78J+0fGFQHJqvyO+ee0Y2xpxBO0XDmen1fHQiqJUSOqszMNtV6nOksa
 S+CSIP9jlWVjqXJ2fehd+K7SlZppc/YD+9x/CsyGmhyaLLpy0T3Fx40U2+tG4e/q
 eBXfXY2OWDztLVl9kOnGOrssxgx5eC8JllWA9giJ+h3XNEvPMwe/PHgxckw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t884qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:14:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so73215ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569645; x=1792174445;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+x5adTMQLmvfmkakNvmA6/CnniszH0zMIj7lqhdRaFo=;
 b=a3QAV0aexhvu/oiR3LYAjC/3ClOLbcjz1KoQL1xY3eUXb2htqr6rq+UXjRo2KFjYFx
 ieUT76gntce4JDWwkaYXWP2kcYLwBHQ0WL2l75Yff/Q7Oma8rjj9POeeF/8475TpxcuQ
 /vF7Pb5oh7MhwRv57TYfDbg1gbez+PJgfmBHuStUn28QWGJV6/ZVbAnvRgJ61g9S/ctQ
 RUZh2q0bejKlKEMhVkytPnnyU8j3ULyDFaA+flH6ExV/jinlUc2CCYY5tY3leCb3UlyD
 na5xBQRWaXUjy3XSJ8BSaoondfTDbND0xH4lMcUcwZ0ERyDXnb8nBkmrlcO7vQvHVQKG
 MsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569645; x=1792174445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+x5adTMQLmvfmkakNvmA6/CnniszH0zMIj7lqhdRaFo=;
 b=ZdcWNWX7wLmkEKR6EXWULh9QAf6RhotQVEgXEKk0j1SZiydB+7zFPktWd7ngWTroDz
 3uAsJKjxRSgW10ouqQ5+kjNWTsIbTKet6F3JrGbmZN51W6q1rSKv6Medo8x2g5yl0tKR
 Jgvo5oDvDXmoHAedm7QAkSKhQfz+aQt07FcsAmsXT5ZqZvA7AItRsP8XGc1xoO3UCEYk
 k9iygh7N1qyzEmcMCQb+0I3rDdQOMHDLrziLy5vM05YU2V+Acazu35Pswk53rXRohsAr
 iDBufZmzUH8Z7TXg/q/QEsQtmk/NppdZhGv1wplBOTqMKbeedFArox6yyaGkC+j0An5Y
 KIfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIQa05LI9drT/HIRF8kLGufJCWjWHn5UwOQdEu86RSgK5zC9EIAppXiJ4Lsnq0SoJShyvqYX4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIH5C8QwvACYm9pdeuv5CPunq6Sxziykh9q9C1GTr+o1hUjfNXK
 jQ7NdJkbKztK9X9xRJZL/TlFVwB834B9FmJERD9gEFi/HHPb6Cs2wPQ3fB7ia4J25xVpABTQCh9
 DTpusRe9x0GRC6N28VqvUJNv6aoSnLwtIZdOZ57PdV2Pnkn2bRC66z8LnnnSF5Vh8OsszaVs=
X-Gm-Gg: AYBFou23dWPk3moMBHAqRaNbVCZtgm1cUULttNYnePAAyylL3PQeRjvdGbl4zKl/vlq
 yh+BogXoI0tgiAE/fq9ElKacX13iyWnnjNUlOFR2Gk6tgFEqpksLqXqIlI1pAoghH/crIE0VzRW
 w+GWczUXB4PLGRU7MyiPmzq920Kz8HGPwVK/Aat6V+LyhHrgxfKTjktwSOQoQBSdK6pSLrKeiIi
 FemPBUL/WbFopG4KiyPRFNbrOerfyIfPy9GMjaZiBEf+oAiKvAukHIDXeDkdUSXgksQc9MLrZGo
 IlwSsPzhrHnxDhlsLpQFNRrSYLtAfiUOZFHyH+5u5nCKZ9HXB6hji9fmyU5Vy3WGBgKV0n/lr8e
 hLxbyxD1eHDaGFTeXZbRxvg05nWa7lILfyPav5BWyzPw0hNftGFlyAo3jdKmRm9TXzsRxjfSoLP
 xuKvqh9w4H3Rt/v+TwNg==
X-Received: by 2002:a17:902:f686:b0:2e8:611b:803c with SMTP id
 d9443c01a7336-2e8611b83e2mr13295975ad.29.1791569644618; 
 Fri, 09 Oct 2026 11:14:04 -0700 (PDT)
X-Received: by 2002:a17:902:f686:b0:2e8:611b:803c with SMTP id
 d9443c01a7336-2e8611b83e2mr13295705ad.29.1791569644101; 
 Fri, 09 Oct 2026 11:14:04 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:14:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 5/7] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
Date: Fri,  9 Oct 2026 23:42:50 +0530
Message-Id: <20261009181252.2334254-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ALAv1yfXX0he3p9UO63DmzbOV8D-vlm9
X-Proofpoint-GUID: ALAv1yfXX0he3p9UO63DmzbOV8D-vlm9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX9BkdJgZbPvUZ
 Tc9xez3kgdrdkSPW70Z645TP0H58ROMUWNU3Oeprqrjf7ciIq2E42eTq3XZEVlZOla5H3Tn1YEv
 ImcXwsTymN4Nk6OgK51NBrfpBeTkSgg=
X-Authority-Analysis: v=2.4 cv=JuNkP84C c=1 sm=1 tr=0 ts=6ac92eed cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=WZ0Oi6wz51U_qUjvFLIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX64UQq6ovsQnt
 e73VEuDLMw5oN4jJVhOHv9Pwa6yU8QgMUJXPbsQwu3GZfOIgn6TxrpzgxOym2hD1caVXYFSD8Zc
 A0xn4TBF199/7kVRAbLeeFDO+SW27QzZ7BaVvzlWNJhDPZ4N+5CpWm5oQHOpP9LMStzhn5KL+UB
 jy1jIsNJl4RfN3TwOWfI9X5J22XOqe9Zzc+peT1Z5CvnqRmbQL934PkTM9naAVUbYslztXSAbUU
 WmyRYyXxx+JHTpi/NSO2nLqoHxsBpaU8XeyKNFcXnqvSvxgfxyZ7bSsYEgEWBefOGfW1hDTwWAL
 cL4DtV+Wcg6jplZm7EIGPK2X67qyf2F6zYNL+PIbTFFh12JDmPfUKcy6oFC4xT6K8J8Sup7lZdh
 uupeeEFXo04JPkdxjTwaWRSH6whSQ4AjiLT6AoM0b9rOyc+3hUPfbG0tn5KCRWlVRerAuCToN1z
 uAbq9QBWXwyEgAnV9og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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

Enable reboot-mode functionality for all Qualcomm platforms that define
reboot-mode device tree nodes. The drivers gracefully handle platforms
without reboot-mode configuration, making it safe to enable globally.

Add config options:
  CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
  CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
  CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access
  CONFIG_REBOOT_MODE_ENV_UPDATE=y - Auto-update reboot-mode env

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589aa..7687e653dc4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -121,6 +121,7 @@ CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_QCOM_RPMH_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
@@ -131,6 +132,9 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SPMI_SDAM=y
+CONFIG_REBOOT_MODE_ENV_UPDATE=y
+CONFIG_REBOOT_MODE_NVMEM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-- 
2.34.1


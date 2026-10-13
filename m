Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E76CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C429E60652;
	Tue, 13 Oct 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0hNPnjwz_6W; Tue, 13 Oct 2026 12:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABFC5605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893701;
	b=Gt4os+f7RrVmIb7TumTKNQ7oRO7sXc+ZTpVjaB4arsGQP/xoiQtTPHF05ZX0e/9zzytj
	 +ol9nb/w/JcrW4hyvQfCMJ0/3DtPjoFOew6HsuIkFz51vp7SvKpXsihznJT0kpXR0nSD2
	 0wAGH4VtSeCNafu7YLHKYFTSLVa229QMhFqBfzDmaSxI9z+thNSQHaF8lvtlbAncct9dx
	 +Xz6W0hiMZCkr12ml/MYCWlWHmDLcrSYaN59AcBdIxGVr0F/ZH6Kired7ETDg6WgKIr+U
	 W2foWdO8mtWUTyWYzB0fJo3mlhdEowt9tZeb9ehxkm1Z2nmZKcPNBUknlLfyxw0OY6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ORuoV5xXBXEoWt7m3FZNe+wcEnhjgIW7NDSbiohga6U=;
	b=BMLfdqR+jCjJvI4PVluqG6hxkEo7jaVU+5vAjbZgEbztxhonhxnrWykdC+V9eDPizRSe
	 bZqY4+Og4Ja8S61KBUC+L9fxTaD4lkHInFmMRaRH0RyuD6Z0X732yDrqcBdy1CqMroOvo
	 pairPntXzNlMNvbPaCh365icPM3dcbX2NORnCnv/U3XY3KzLWSXvHdG4ywtc/6yXqob+s
	 0+PxIqkrAFQQJ+5erHiFSG+6MbkmMnMakRDjgBB5XO5d2zRL/2LR/62kdbC9gCMarAkTV
	 c5UPMoo3Plkgvpe37V/aDRB2FO2vRU35G92qC+7pps8ab1/104JqRY36aevP5ZyGdSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791893701;
	bh=ORuoV5xXBXEoWt7m3FZNe+wcEnhjgIW7NDSbiohga6U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dvO8U7BGKJdk+qkiIN1/QJuV5gOrKxbsNevcrSr19OHW53JXvVtwdMMmLZf+dQ8wr
	 GCWR9BkW+HM6y3TyC5kvW0K77DlWWS2u6KiunYuw3ReIeMVmQR4lnPChh/4DKb72iV
	 YjmCyaLjaJz6bqfe95NQy/Cmk04R38xXg1zMJXLIIWMOkJCurQV/3mrqKWbSjbNhiz
	 LfCD0S2cwCKHVmIZJgO9z370ElX/8QROk1+iaSl+CIwxz52mRWoYS8h1P/br6BS4kR
	 KJ7md7khgl2v7+i+HXd+B6zSxg+J1tmeDAJrLDxYzIZSP4RUK6hGrjrRM0oP0y+leP
	 jsLRMlNp1DXKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABFC5605F3;
	Tue, 13 Oct 2026 12:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D83C235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E581400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cD_ZzeXzDzuK for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F5DA40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893699;
 b=nBANQw9EB0HVLhBNp0LyWorhHlrKgWQFSZxr+DIUXz0cK+14C4OjOmFAg7pdZJtne4PT
 C1+priyTJVreAENv4wowGjh2x5WvMrioQiB1n6/osyT5lb1t4980kaLapiNqYrSyzlk4x
 qAIKBz3azOOmQvFr8mte3mhni1+N+cxzkqLBpmycvzSFOaZyVaIZa4eysKDypoSPYBA/5
 fKyARWp6IMJHeOP+22np7EsD0BGLuXswLumOkB2736V/8VgeW3onwQT1AeCtjpU9YYUPs
 Kxlno0x5ovHNamV5VTWshkVKHAN07WTi501GHeVjQ17eghzbhyMdrAF4Gz2syZGo2fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893699;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ORuoV5xXBXEoWt7m3FZNe+wcEnhjgIW7NDSbiohga6U=;
 b=SSG1LcswHBuGMTzBCXXzW9EjDxmoB2bnojtGIenq02h4n7MLaLuxPw37EFBPosEGdiKf
 vmeO63hV3VuN3+MFolygssz4ks50lfNZxFz92XgGcp+gp1P1l8s/pa8713N/a0eoZO0sF
 8R//R9/2iQ930uwV7KZT7bOr/ftamzMp9/kw++NYEgHlu3DFkJjC7wLKoXs5iEj5FLEwJ
 crr7UTiMLtnNeFM5fmmyBgmcmzP8IuTy1By1iuaBufYmenxdBFGiDvyF/bQxo0Aq97xnU
 2554Z1a6s9xUqgHIVM8w/cF4O8aDti9qz2IeEIFs73eT/QHzriC+vo3peJwPxvTd2ZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KfkDul1X; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CburPnKb; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=KfkDul1X; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CburPnKb
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F5DA40070
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:14:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D901vk791192
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ORuoV5xXBXEoWt7m3FZNe+
 wcEnhjgIW7NDSbiohga6U=; b=KfkDul1XvUEfvqIqk4f2Yllj0Tc1m9NSbUhBs9
 YRTdO5TbO4ZneONHbeRPN06GbPVee+qpiU5lMQHj+an9qsllZo/kFuQi4Ik8VIec
 PK3fs5uTbRY3LUSt47L5kMgtQ2Y0ElBwZacQ+Q8V57y/gV7WR9BYVqjGJDvYW7bi
 u+FxxbsDJAQO2rth8dy05qpgohdA6NOT6sCOBe+o5gq+6ztw0T5mzv1VT7DfKwBG
 7M18WpAmz2TAUQPB5JuRyHeAhCTlgmMweKKBtd9OIageD+2NDVhsMy5GsH0qYGz1
 lNRLbxhXGKwsc2QyD7HlKOzJvSz3Y1hzWhvyX0BLVUNWRkdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrsmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:14:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so681349085a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791893695; x=1792498495;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ORuoV5xXBXEoWt7m3FZNe+wcEnhjgIW7NDSbiohga6U=;
 b=CburPnKb0s6chHxqzzR/juKxcApJx1tLluCPK+K81l/QvRuSBa6RZijaz2BIS17Iq0
 zxqvD5vnaFRfHyobWaQ1x2J309cXXBQ90Lb0P9TUlmfokRSu7YH/GQPciQXwDuQAd1L3
 68VZ841RihsnjNjepRfvQiCQB7AqLXpgQ+iSJ1alW4k1d25B2G3ACz4gwTn/hIySYW0s
 YO3zQX1zLCisZSbTNy3JQDje83PBbpgEQN5BRDMD3xTkHS+rnI+995TrYl0fr1EvBreH
 4qRlTB8qepd15bDr4nilYENfpweABA1usxJRfe2co0BxLs0mfdOR16t1CVFGX0NhFRef
 bX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893695; x=1792498495;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ORuoV5xXBXEoWt7m3FZNe+wcEnhjgIW7NDSbiohga6U=;
 b=DvifaSn13acL04caxJgG5Z0PfExRLQ+/jaXw2HX7u7Yz7LHgEQ4wQRtWyOCauLv2dn
 GISAwTKgNnliGKLa8GjzakQiH62RGEQFWR59Ed7NwKiVBIVWvX40RiRCBNPL1n3MPpaD
 WRYUrSvjxvFMzInBUTxwD3Of6dCFbfEOqGWVVAby7rV/W5qltT+PJKHivM4Ou4P652R5
 0cXAQL4d2wKwz9PmjCk+bzmsL3wBvV5Hdvk5iCgMFXmC/Ac1wjr20wgKX+KMhyZLqn9j
 sASj+S29QcMLA+eJ+7F5C4QqCtUBjs5dOKM7f+ZTvItW6cnAwwfOmktDWvONJve/Ye2O
 XW/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKAX2wO4Iv3TFWXo8B6UYA+J+z8tFf9S1vHgh7onHezs2Vtrlt2dolGHjYwT3jyt7PJF40G2g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtQ+692Yy9vE6AY0Md/OhJPvyhN7LcL/k7yLLOCQvAnR4trVgr
 6lOX6moFQgW0CZF7dgezcjRs9IIh5QeHHJvLswBaoWQLvv4khscEzAjey3MoZKJFL8Nlv6qQti3
 ODh7xZXbsrZMTryISugxizpppkfNpWrb024izO66lMzgwmMIrGjXPH/gcfNJK1UXEROcSpA8=
X-Gm-Gg: AYBFou1umrafEbaL4l5DAOwyVenKWQvxAqeFaa0O/rKCoHzC5i77ATrrGHr8A4wDqnG
 +PQ0tHV+IZ7wpWyLiUcePnZ4unX5Z9xzyrb/cqoGG+tg3wmqnebzayHAtVAxR2x+SCGrtxixnK1
 Fn/+jBHcf/uTOYIMecbBRLbF7lQ30kzjRbMZRc6DGnlQvMWkqd9fqTPjhyfS9jmYy6oGPxAPsvP
 MfxR4WVSpY5uaGSMiWK+f2ke2E9jfVb1iuVx50YxSewwvqzB6j4Axefg4rouCVY82xuBSrgXhnJ
 HXRRpNlVWyw0YxDTprCOlMl/Y0HnBMW6Gt02XWXtkujCdoZUvaA213mrGq4iiawckydj4SJ9G1f
 o67HkGDi1TMlQWLvXGIYEhFxgCjUkgsCFjS6X3jWJ1UQp
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id
 af79cd13be357-93ebd248c51mr1925707185a.38.1791893695351; 
 Tue, 13 Oct 2026 05:14:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id
 af79cd13be357-93ebd248c51mr1925702385a.38.1791893694830; 
 Tue, 13 Oct 2026 05:14:54 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac774esm571050866b.68.2026.10.13.05.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:14:53 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:14:34 +0200
Subject: [PATCH v2] mmc: sdhci: do not time out a command that has
 completed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-upstream-mmc_sdhci_timeout_b4-v2-1-7c6383b789a5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6DIBBFr2JYFyuIJu2q92iMARwrTQHLoLEx3
 r1iL9DNT96fyctfCUIwgOSarSTAbNB4twM/ZUQP0j2Amm5nwgtes4IxOo0YA0hLrdUtdoM2bTQ
 W/BRbJWgJ0AspKlErTXbHGKA3y+G/Nz/GST1BxyRNH0oiUBWk00OqOnDL2cES020wGH34HONml
 hz/7pgZZbQvS11wIaoLFzePmL8n+dLe2nwP0mzb9gUQM1Ba/wAAAA==
X-Change-ID: 20261011-upstream-mmc_sdhci_timeout_b4-3eef4a4546bc
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX0lUmr66BbiZ2
 k26FyeRkjxt9nmkon2VTxnbi5tE64By/9Rwzb87BSI3pV5c/8BvXRk/rBPAfcSr0nRc6oPNbkRv
 mqXI6fiv+at5FxuH8WYsSnhTcOmDjes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX4y1S4jXNnzEy
 yH5IiJhsZeNjY/nd0omsGyMmV3vDsxXK+gYqQuZR1TE2I9TIdExty1G/gIKFc1cpmcmYgDs4kgx
 CxDQeuzVcy3kOPJmFaoAfaGFT4HCkYcHzROqqGSXEBpyFKIeP+I+YR7mhj71g+RkhSfQqhQa1du
 x8llHcGW6y5RGczu5NDsOfHG94WgC+hMAgmglRXTgSn8c+0JP+qM6KPC3UoDwluw6xPuL5YO8SO
 vQp+eE+RA1NrK83teYZ6UN84gfOX2ceZbR91rwr4N/1vGySE4mqnOXe8f75oOGDjIn1LdvSGnDO
 RLoqFUfUEwI3visSfigGRLgtNg0byABx9d35Qdo6SlQnbN2fZg4dO6Pwuk8H6E3bkvSvwbFeJo/
 ij3EX/jiAlFK0/TzaCqA+g55Ku9tJM+ODwoJ93Jv8nPVTNGX43QV0GTCkf/hiWV4wGymeDZNsGS
 tM+b68FWDYHrvq0lZKA==
X-Proofpoint-ORIG-GUID: fHQDNfGX4xCi8rYeHN97Mxj8_vX2GtTM
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace20bf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=xEOYyC6cwIeBg0oB:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VKJPOtqduyfnXUeptp8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: fHQDNfGX4xCi8rYeHN97Mxj8_vX2GtTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130048
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

sdhci_send_command() polls the interrupt status and gives up after
SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
the status it has just read. When a single status read takes longer than
the timeout, the command is reported as timed out although the response
and transfer-complete bits are already set, and the caller aborts an
otherwise successful transfer.

This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
runs in a timer callback while holding the big QEMU lock, so U-Boot's next
MMIO read blocks for seconds and the subsequent command appears to have
timed out ("Timeout for status update: 00000003 00000001").

Check for completion first and only then for the timeout. The check sits
after the SDHCI_QUIRK_BROKEN_R1B handling so that, for a busy command
without data on such a controller, the quirk keeps returning as soon as
the DAT line is idle without reading the response, exactly as before.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v2:
- move the completion check below the SDHCI_QUIRK_BROKEN_R1B block so
  that the quirk keeps returning as soon as DAT is idle, without reading
  the response, for a busy command without data (Tanmay Kathpalia)
- add Peng Fan's Reviewed-by from v1; only the position of the check
  changed
- Link to v1: https://patch.msgid.link/20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com
---
 drivers/mmc/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 962a99cd05a..97de02c262c 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -315,6 +315,18 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 				return 0;
 		}
 
+		/*
+		 * Check completion before the timeout: the status read itself
+		 * may have taken longer than SDHCI_READ_STATUS_TIMEOUT (for
+		 * example when an emulated controller performs a long DMA
+		 * transfer while holding the guest's MMIO path), and a command
+		 * that has completed must not be reported as timed out. The
+		 * BROKEN_R1B quirk above keeps precedence and returns as soon
+		 * as the DAT line is idle, as it did before.
+		 */
+		if ((stat & mask) == mask)
+			break;
+
 		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
 			log_warning("Timeout for status update: %08x %08x\n",
 				    stat, mask);

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-mmc_sdhci_timeout_b4-3eef4a4546bc

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F14CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B68060761;
	Mon, 19 Oct 2026 10:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vr7xd749aICd; Mon, 19 Oct 2026 10:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 819C46073D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407073;
	b=Z8Bd46zkBtV823xAIsBQ3+Cy7z/LxD0W7icUaEBS6tqoxqRDh3DyC0sRH5HnYFAB+O6T
	 3wshPQ7Bku46Ytt60Nr8bkuO6SxzFc3ciz632B71RAD5mhN0kk0eNUVZWjaqQN5GKY0pP
	 i09BtckimisnIsYImXeQcdIboBolI8TLS/cozmO4P9UOam0io3H1aP/yriKvWYS4tpTzF
	 AQHIfpv76ZSPeG36lG36LEDsGgNUUiAyxsj1I3OnAoNdLJLRfXE7i4AubjweoCC708EyH
	 jZPznrXW6OGYbe50xSEMoOt3RPVOOLR83QG8xCtN7xJNJ6Zb7o/j0Ig+NoQzeRS8anA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=;
	b=FyqverLOkdbGGaXGW3Sejlg42uOHcw+rhSsAC19QmDxn7de+c5qJWmpiMxKy8Cpc+2sa
	 Wf9N9prSPpiE4JA4uD8+Xk/K2+awaEbyR0PYBuoegZKdKlrSPE5vcfxfN9us6QldQqjBX
	 xYCbO/QLzLs4R7zomNQr/RUGS1Se4oeAioJmPuRD+43jGQb0hnkvnimZB9eeQfd96NZwb
	 gWzO2sAjHAXCCgvToreu0S0PKuaS9eIFXQHaPrIEt3lxeGXBM3Gu0WUWYedbi8QrkIcos
	 UrfAuZV9WBpGDhddiuX79X59DDKlaB6TWj8VwlErhKmlWHodzS2rYaMziWVX+RFC08Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407073;
	bh=s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdQvSVlNqLjQGWLRq/S/+SFYf4Ru/vnrkKR7bGN+B6fqP8uQif26JuiIR3WVBEEBd
	 yxPEzitD13OfNSVadVwLQLPN0G6VUPwwaIxyNCGMRJ7U7Wc7PrmRObn6Vc5tDT9sr4
	 r/r4LSPxf1YsYqNEZMa+ZWtQiBTGA25FhfkrHbykQq1hMbiczjRuERQwuS9PhiYQnR
	 uOlARniQCAWNkJmzC9BwlSzuHJ8fvksZDetO1EauHpuQavmtKIGpmHV6xF240RxZLJ
	 T+y3oyACwBkpZ4ftOyrD8+3kc9wfnp1qyVowOuFJLlxZvDpqmqj2vax3wb2nZnWtWX
	 nuIXvks0TT9/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 819C46073D;
	Mon, 19 Oct 2026 10:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0AC61DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E27CB407B3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRHC8EKwWQjy for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22CFA406B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407070;
 b=o527YlEgW85/MHbepAjBWDQKJFJOHWX5EQ0zCjLDqlyigsNL5RuB6TLLxEl44CO+02mq
 jYKBcg9JNFOuJ1YFJ6k/mcT/IRZ3Yz3q8s1dNt2Pd+pSaYPAKUvJ7s0ojy36QsaX/g2ST
 /KCLH2PSdAKEOhsXUD2VO79V3m4v8CnO3eEv6PGfShbWuKawyWrc9DmU6AlBCWu2LGbfs
 6ppLyIsgxle6mk8WRN6i/84PvdKkVuy4/6VJ8mrDI4m4M/jJhqtDHX124+Ps+u3YZMwmg
 +BuK+tWr7JJ2bM8cwM9oF25NgLkUsRtJ7TzNebvQ8w2jxjOeQLdMj/tIyRIA2FZJDWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407070;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=;
 b=PexG/d5C5icqlPz0IFzQvdAoRMyN86CNWZf+Cba8dhCOfwLvfz6ifQNlsrSkKo4AU7Jq
 U9M0dfVsw1J7PFRa1fBbwK3qRCL39IHNox7D9iXSM24XS+k2XgPDcfuc7Os6Knr4LxANW
 JisW4Kt6dWFWjAj++lcwBbEypfhpoy1lo0ZxfMamo355CF1HrQjEO3sMdJlS3S5qSTwL7
 U/R8qECS7JDoxVkJyrtTvtEznL4+UKGjhC0hV5teOIueD5AbcPSg/9QEsLODaZZg3kxNy
 eSD/5953Rs7411XAeUB0mEBvDsoyCFKZT11IgMAU3GbZjxsDbcth5f0OkC/usDtm4aQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OiaUvzNo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L9xE3Ztj; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaUvzNo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L9xE3Ztj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22CFA406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OvEj1168064
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=; b=OiaUvzNoxOa16fwk
 NG2ZWutgj+DPjIaEKf5wDZOjgHODO2GEQNtLj9J/OMEBQiiEmRX/eNiHNUPNaCSS
 triLLd8iCjxuCfixDIjd/dx7/Bl8T4sNvFZBYbfMKE4vJEqW0QRyRTET3/L4b3YU
 6E4bMbC7TQQ5TU2VVXWzf2QafAT9I98g4pxg7C6SlVzli6LbY3KsSYk2gz+dR/29
 i7zKZVOHhdM24GqAH+3m/AZ3IDvqroUcn5tnsFo6j4ABUUzYA22hQxKhWPGtJYK5
 yYScK9R+o9w5GsaoOZBvNeJfVoKCb9e4e1Hxepf+cWlFOFlPKKNevcF3eEDy19/m
 nizLbQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8pfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so8895682c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407067; x=1793011867;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=;
 b=L9xE3Ztj77WhlUCj+Dh4APzoCuDyjfbkHL1vFmAgN/TV185iZpGxeYdlevWSp4J2G+
 uE8YwNWTIkltkyjLdlEQDEE6UfvOs6XE7gsD2gXfsN93TG7g/KRRDWLM87pt9gJTpFYO
 oZXQZvPNMNXKWIL98VpxF+HrmzBazbpOMBDczn+ITloQLmVHE7PDKS99SLy3kxSaPZnJ
 WrCE99n7/QohTLa7gIDxGIe2avw9uZtFJRJ9ccyH/d4HPAIqn0NMjT7rQaaGDLRjcjYA
 0zY96xnjyXJcu4n8oRhYJ+AY9SY1OQT+Zu+0tZphchK+D1bjOHNtu/olE8IQrexvNUVN
 isjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407067; x=1793011867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s+jAj4eUIRyhkAlthxE8ACKidZxIQItUupV+wIjaZ1E=;
 b=1AT4JymFQQhEzyzKT5hMQJwMA+o4iXv7opjAw7pvc/nwcdPJE0SVIMBQhPhaPs9evf
 jEVoS/NQzccmfk3UEuGhKjUNPEPTcd0e4dRoQhReUQQCpPuEuhPWv1xqJybgQY3soM/c
 pv1TS/y/PUvbHkEVWIG6ESIZyN4KmPDd9UzIIK9d4yT1B+JradG4t4zxpGiRO9/uPjCK
 4FaDB/5bmY3hZjdur0TiAWp30y+ZTI8pD46lNwOD/SJdVqoQ659jBzsKeaMVBaUYuU88
 h5r538rogK72LqWUXicRrZN+T4fR14P8yq82snjyPTK8w+2yg9TE/u4mH+PVWd0VZN/2
 r9fA==
X-Gm-Message-State: AFq9FYJnaW8BxmK0CKuJ1Y2+fV3QYWpYb6rv0IWzKVbmKuMYwnETED8V
 rE5THSuv2aA9KhjkxpeXNQSWRVN3MFn/zdpmvrTZxdvWIB65YasbeFdpYYd32JYgPV3TcW6h0XH
 yLSpPPIZ64Psb0JSb595QvaE3ooxJR2qIj242x5N+QAVhzWy86UEzcjXwST9nN8lhryP5FhI=
X-Gm-Gg: AYBFou1Ym1SU3OUoWZOyROdWS5ruuK953wAzZZub0h/5hngMZULeq2RcUhdTMExmgHF
 ADgkH6H2uOAHL1eou9tRUwANPMBoARtwcy3iU0i4yAls2UoSMeYETfV8DGEQ5SnDvqhOdg/jqiR
 3tN09Ux90foWHcC+Y+T2U+QN9Hku+v4fbM4li2EsEi/QqbPxf1hUkw9MO75vqLQEGspJlggWDUo
 il9tGSeGmwRzuf748EXPiUSbioFtjbgT5iGL3VrCif+6JWct9qcJvdJ9WWKXMFsL4so8HoxCwHU
 XfxhLOBUexIF4B+6xhO4ebBVKQxeHyEHbjAFeo1vsAxB+a4kGkKW0PD2eDq68o6w33meAuuqab1
 HODEOTVXY/4BqZ372kxAMaEqb7pmVfi3aJJjm/ge5P9bK8Q9S9DRdb1nV4zTvFF6lXQVjBNxQQo
 ZIVteiNk2uIqz+JJNcwXYQsLkEuEzR
X-Received: by 2002:a05:7022:e808:b0:14a:51c8:e9fd with SMTP id
 a92af1059eb24-185139aa548mr12088269c88.26.1792407066929; 
 Mon, 19 Oct 2026 03:51:06 -0700 (PDT)
X-Received: by 2002:a05:7022:e808:b0:14a:51c8:e9fd with SMTP id
 a92af1059eb24-185139aa548mr12088216c88.26.1792407066217; 
 Mon, 19 Oct 2026 03:51:06 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:51:05 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:19:01 +0530
Subject: [PATCH v4 6/9] spl: ufs: add Kconfig choice for U-Boot location method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-6-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=3265;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=M6GwrtthP3A5g1YqulQC8ij8ki7xE6T+5iy2JsTw+/Y=;
 b=Xnyyt7+BNNUgEuT1tt2sq69QwdWwyZ0tgU2Np63Jp1eD3/ipmMGmE9N8nQUGxcLjkmXaEJIj2
 jdO0K5WFsCkCqP0ezMFJVskIV5+CqZPoL0euv6ZrqlNwTb7ktdEWXCO
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX/ETpRwafE+Mq
 BU/uHefxIQyzKznAYEjUnfm0oyqDdreuvlF676iw4f7BbBMlGhjstXU86p41xVIE75TzXjA1Cdr
 Vs/4oimmblLlqYNE5InRPPyGPndbozU=
X-Proofpoint-ORIG-GUID: H8huJKSMY3jBg2Bu1GDNXpzE6x_C0erN
X-Proofpoint-GUID: H8huJKSMY3jBg2Bu1GDNXpzE6x_C0erN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXwl535yGe4Y+o
 0fweBiQ5an7Bl3tXmyKG7ghr+42T/dlD0vxDmcgCrsVyWCv5SMWXqN6EKZYEdo6wZ2q9704QMBV
 iyvjMccUckscLiXfEd3LFel+AARLs4T0/Dx4n/tGIEB6Z0P2YpRCdUfiw6JNWI6H8sy+HFA/vWQ
 d7BVTh0YTCkAbBKsQBByyT3jok3vhoNgX2EjwS8XXNeKL93yFgzsnrlLdqXTH2w3ohPbulHJzaI
 p0hPLJuGWRZ1o6Gb7TBFlef01r8ofAtOcMr9Qq2ByX98btVIdSPEqpQb5nr/S5VH93VydnZpb25
 3Xut15UjHlPgmJAQ5GXKgyNFEgGNOl2g+G7JPurHrHg5Lj8wMvBNsdSKzwFU02sjkVqkdC83EB9
 r3tia0eay+lZmSA+LW4D7lsOIR5EAYFjwTI3DhIGwWLjratI3f2fSvuARdGH9y/8z0sBsJbI4w+
 wZm/4L3J85iI5NyKzfA==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5f61c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0MC_39LZJF0Zaw0hVAIA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Replace the single SPL_UFS_RAW_U_BOOT_SECTOR config with a Kconfig
choice that lets the user select how U-Boot is located on the UFS
LUN: by absolute sector offset or by partition.

The sector-based path (SPL_UFS_RAW_U_BOOT_USE_SECTOR) retains the
existing SPL_UFS_RAW_U_BOOT_SECTOR option with an explicit default
of 0x0.

The partition-based path (SPL_UFS_RAW_U_BOOT_USE_PARTITION) adds
SPL_UFS_RAW_U_BOOT_PARTITION_NAME and
SPL_UFS_RAW_U_BOOT_PARTITION_NUM, allowing U-Boot to be loaded by
partition name (tried first) or partition number as a fallback.
SPL_LIBDISK_SUPPORT is automatically selected when this path is
chosen.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes

Changes in v3:
- No changes

Changes in v2:
- Introduce SPL_UFS_RAW_U_BOOT_USE_SECTOR to clearly select between
  sector based or partition based lookup
---
 common/spl/Kconfig | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c837f831212..a32c5fd11e6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1660,13 +1660,53 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 	  SCSI device number, which might differ from the UFS LUN if you have
 	  multiple SCSI devices attached and recognized by the SPL.
 
-config SPL_UFS_RAW_U_BOOT_SECTOR
-	hex "Address on the UFS to load U-Boot from"
+choice
+	prompt "Method for locating U-Boot on UFS"
 	depends on SPL_UFS
+	default SPL_UFS_RAW_U_BOOT_USE_SECTOR
+
+config SPL_UFS_RAW_U_BOOT_USE_SECTOR
+	bool "UFS raw mode: by sector"
+	help
+	  Use absolute sector number for specifying U-Boot location on UFS LUN.
+	  When selected, SPL_UFS_RAW_U_BOOT_SECTOR specifies the sector offset.
+
+config SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	bool "UFS raw mode: by partition"
+	select SPL_LIBDISK_SUPPORT
+	help
+	  Use a partition for loading U-Boot when using UFS in raw mode.
+	  You can specify either a partition name or partition number.
+
+endchoice
+
+config SPL_UFS_RAW_U_BOOT_SECTOR
+	hex "Sector offset to load U-Boot from in UFS raw mode"
+	depends on SPL_UFS_RAW_U_BOOT_USE_SECTOR
 	default 0x800 if ARCH_ROCKCHIP
+	default 0x0
 	help
-	  Address on the block device to load U-Boot from.
+	  Absolute sector offset on the UFS LUN to load U-Boot from.
 	  Units: UFS sectors (1 sector = 4096 bytes).
+	  Note: Setting this to 0x0 will load from the start of the LUN.
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	string "Partition name to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	help
+	  Name of the partition to load U-Boot from in UFS raw mode.
+	  This is tried before partition number lookup.
+	  Leave empty to skip name-based lookup.
+	  Example: "boot", "uefi", "dtb_a"
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
+	int "Partition number to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	default 1
+	help
+	  Partition number to load U-Boot from when using UFS raw mode
+	  with partition support. This is used if partition name is not
+	  specified or not found.
 
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"

-- 
2.34.1


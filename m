Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD632606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oKp03d/b;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dcQqwR53;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WAZdR2GZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9225607FB;
	Tue, 20 Oct 2026 02:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBxADLJsG8LY; Tue, 20 Oct 2026 02:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CF686081A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792463872;
	b=BhSmOBd8Ia4JaWAw7VQlK0K4oqMMNSx09OrfSZvHDq8uIL+ODvEjV9T2MEwNDXFqhGeW
	 EsqB4NkzoRcBP1f8KLSAX7Vh0BJpR9xrCpz0ZET15y1VqSinBEGid40vSDJQXj9yByMA1
	 o+gtN5T+eUpgQ2cCwzP/WMe8YF22HS2If9S5naKG7WoX0dtRML25qCTeU7xD8MDGjCw6W
	 KEbadMcLqMH96tf2DpiUCdsDMar3fwi+213750JT5lvHC7WXlfAIUAEAOlHBdOlA+iQPm
	 spt8l52/LqIqLVFOPLqiS1Y9xPY87aX/F/RCgUJG44VZhfsll1rOnEeIDfxsjH/U19A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792463872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=;
	b=CKJGdLH5R8+55zmTW7bd7MDXuWPI53r+OQj+NOuQxiMDDtKSsz79xtntprGsht23goI+
	 KuqzomLVtHZSuWnZjNKBujsEkZkI+or3Oo5mifEhKxAR1iF005j3ZTmB2kZ/xgHb45wm0
	 K17d7NsiWlth3KjtEe13KC2v2Z1MSKzPanY17zXaRp0eS9xIfLa9FlyqoWa1Myixqk+Cg
	 Xuhb/B1NCs4tUpB74wrgF83im4pKvt9+ucIweSIPAK0rg+4H3bZuGSFjG2bqmDVPHNgzH
	 rx91PVF2TfJOxDIsgIOHr/2HXiUG93AX66B6+Gn5fLl0NuQqRz4gbB77pm8mjd6gcfA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792463872;
	bh=CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKp03d/bSh3dJo4JCoVl3jK2/nR/Uk46oVTvMgJSkhCaMLakr9/Wpq9LE8Jg4p5Ja
	 XJygmULCcUNgsB331Dy5TUh0y9B+Hudn8DDhl1SXA63XR1VxuGjuQFWx6cV0o4JvGi
	 1EtTpLO0w7AmcOGM1VQ58hOuHG9KtvrJ4dE7rBmbkhyOq9qoIcW+yLSmD41f/ATs2j
	 Vfl1FwCvlWzS61JMf99OW7gBJxdGQdmBwPMSQSiZONu9elf3cIPWgDh5ZbW+VXIO9m
	 BCI1kaepKFr70vBub2eXT1pm1TROguK+p0AId4iGuV+65OmA6xMcbT9HQqghxdOT3c
	 8MDdAfT/NhCTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF686081A;
	Tue, 20 Oct 2026 02:37:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1CBD12F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3516810AE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2aQIH2yznOFv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 02:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AA6A809C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792463869;
 b=sjd/n7GvY5px9dVlbsT6TyhrQPdpEPuLJV8lx0+D03gjdY68WdSYRxc1OMvSjb4XnM/V
 IFfXebWpKqzsveyNZD+t9KdycTWwNS7pUFU1iODIbRaHmKNu7w+QQ0s+wqt75PuNGyXm/
 tF4dOFlvBfEi7TcWqm6oIjx5YRGP54wtY1hco7b0SCIYeq33zNZ8YlFpn5k80UCo/ONAx
 gCBs3PkVoCvA8eN1YR6puMV2IoSbjQeqaMXc3dztcborg9SJnbrYcYVqmU2/c/m2STqdl
 uT2C9pHHO/wJkVvkTrbdKuAV/BRIIE5rEKxwHpanm4o8HE+2i6/WvNtkJJthoZ4/9NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792463869;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=;
 b=F87WSCBcE9CMkvcqWV+7MASpOHWfY692062j1/bOKt4XtAVKdfkvyRE79Jg2UTlGFeQ5
 hU3xqFhxwdx81joo8aHzeNJ0m4gduCa2//rRai6B1kSFWhczrIBlPa47SPEjd1SsrR8Yv
 CATgF2XBUdKszR2eNf+HitsUp3YWYZQUbOXSvNy4SmeC5vDNNxJaspZMd9v2PxFhpxJhM
 vJc7nSzkFtAeEnQd+YzhOO1IEM5D+6JLL3SIWcZaZd0xlBqzTUEkqBSOrDU45jLjAbUpk
 +Ib98QGp8/nuNEZW5j5bosTr9wvbCukjlGDXkJj//99lYO0G8CGgtRbTKIQU9YAqOmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dcQqwR53; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WAZdR2GZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dcQqwR53; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WAZdR2GZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AA6A809C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tEIL2877818
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=; b=dcQqwR5339vgN3PA
 o9iPelz1j61AZwWltURNZZXbOViL4McRxfMAaDZ+pHM6wwJUp8z5NszAn61tnhPh
 8gz6lwGNpQOYj4HTSXtUsjJGrDRNjhRI0BbsJpGNAFz4YwjordONSwJdBdx0YjIb
 8H8faZfTe8Hi3PZ+kRLgMnrvJM5RpkocbJ+3OP5V+enWef9C/IruETJQMtDD1Trh
 ro133Y7A+e0T3b0gN+vZW+3qZ8ufZ9Hti/Q9WA3g/xxjIUbHly7WCZbvGFnvuggc
 33SPt61VJDF5QuWFqf2oSdCaJYh4VvgQ+Gvz+CmANWPsBgi9NfkizyrpLeUKYpuq
 0+hayg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5prgqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so9330093eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463867; x=1793068667;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=;
 b=WAZdR2GZ7sny5e6F9Br1pD7RxPv9CzhES8ZPMYsq5vQtFJbDF1mOgL46vhBCoOlD3E
 1ccSyHQBTEEB8AxgxytYSofFGQ1Hm5nvXfLzcu28ru5f+EEXoUeqtTNAjLvtxim83Z5u
 9kH3T7f3XoIDVWzf8T1XlH7/E1SqrcQSnjRv5x31KWaJmcYt4it41+fWDMm9iYyOWr0H
 QuNoTOaRitxUYoMldp75LsjOa1qqb8kR6xAGZWGUeryPHp8Gfh64Tnjas0U4Yn2Y/Nrm
 Vvl4LZi7gpTwYmwZivQ3yyS14hOhfKGabM8UoTWGTlz0nmCDEmmj2dlTG/ERVWcX3c/b
 ao1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463867; x=1793068667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CoLgJUCZ7NcvnFzAeSsWDvEF+h14YHsSt3VJFEPX3eI=;
 b=oqwr2vpFgQSLHF1Jfkgjdh/6GT9CZ/rUTPy0onDLSWlQ8KYTym3D5Qggae0H9AZ1qp
 JN99sbXb8e41AIr5vvJ7GhhKjb8ILdiHE9wGO/Qrc6htbBEI7+tlE2U0n4e17rpCZHl9
 r1rKU0OMJjOoRNdhcsc3ssv5IJng9IAqn9NxReba2vDqPcIr2WD+SFiJibv9lkVvoWRQ
 IUAlx+Mjhu5KlLM5WoLcjq4AhMvKc8XGXhCJDpg7QORwFhlVsDA3VSlZspEhj5t5W5Ia
 jGbfX3wEaoyCcqz5X8zaEZ31GmaxA1B0+rkfg242IS+tqT0D7QqW2NM0xVoriVBJUVRb
 H4UA==
X-Forwarded-Encrypted: i=1;
 AKwUvByICi35Sap9OiyK7zzvywGDjQloA9W1hE9/OhYIhUdDQoomRN1EIhKm/FPBTCdOe5ptcemGUMI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ1Bphdy2C3IEng30IBQUZQl/WPleZKRg15zxgX/n+34nRPkP3x
 orAuo8+8KYEd5yj528MnLKDvP5x0sifitU/eLGArkiFEnJB7UKo/SEg+dF7/We4ikvoGg479pdk
 NW6vIBp+ftTFdcjeerqYG/O0wGxJ9u+MFqR2/IoY2b1CazwTdw1H0pAPiK0ipOdP4NktEHisUj3
 9WuTg=
X-Gm-Gg: AYBFou3oUy3oi+V5jdIbvrsKfOn7fBfgnafNE2CbPi4iJgMkERG/o/s3JMfiDb3z1Xo
 gTevOHkPLWj76CPlP0tpKiwSXzlGPqxRAzDmMg0IQIhzAe2zzhLrJJUlTdVt87rgBJoEd1qv0Fh
 vQQXE6xfEF7V9gs9v3QbHWNZTJCeJsmjkPwbPVTgCNAfgU3cAt0N7WcHD++Zt6WrscP9u9JUud8
 sw0QkylnS7GgYUqp1Hf2HdUHKP076kTTwcLLRWdBUKgZgP4M742mOM2ErNM852cHbHsmEsgcEvv
 yq+zAWoQeuBpbBiT87z+j9HcRJHN86n0+LqC6vQ2WIrLhvmweKUKmEvFTzVXQf4w3DcfMmaMDeK
 WeV35G/cZJye94jFsDYkQSKmJr58S60uEAzdRq8yrU3rwvNLgJLsdP/z1Yrdm16RvsA6KDdY5e5
 bGHA9Y3GSCTm/86E2q+05AAGTIiJL0
X-Received: by 2002:a05:7301:2727:b0:343:fb75:a5f2 with SMTP id
 5a478bee46e88-361a1865981mr13278880eec.9.1792463867275; 
 Mon, 19 Oct 2026 19:37:47 -0700 (PDT)
X-Received: by 2002:a05:7301:2727:b0:343:fb75:a5f2 with SMTP id
 5a478bee46e88-361a1865981mr13278849eec.9.1792463866731; 
 Mon, 19 Oct 2026 19:37:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm36349143eec.25.2026.10.19.19.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:37:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:07:37 +0530
Subject: [PATCH 1/3] configs: qcom_qcs615: Enable Gunyah exit support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-gunyah-exit-boards-v1-1-39ec03d9e365@oss.qualcomm.com>
References: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
In-Reply-To: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792463859; l=698;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0oARw3GSgvRqCiBclbk29tLNmZJfzFNtjjOieZeOLjg=;
 b=EZDepOukLqNLIKPHNAMAA2xQQxgw79FPGo1zI4pZViXJo09LMs9/Z5SfpOGdsQ07ZL7+YdQvE
 K14K7ZbBNafBa8DBn0G1tpiUkGXzIympVgsxIkkjMcaWx2EkaGdpTjb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad6d3fc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LQnI3jyB7ACyRaMh0zsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX0o0JCyhIBfGr
 PCqXadm5XIxBqbU21yLxhIWThyz83eatb6XUOO0R7N0onzjLxMD57FYPLf1DVTXUJabCw+JU0mo
 UmWQBpj0uKD9FJNsYKouQZhwtfz9JYL9ZrFniYZF+xFY5wQqZ2MChSu4EPrgMnN6X2d0+MNuion
 7dGAvdfCdm1TEzUF9Ci5zM19lseLzRUhSPLihsM+Or35sh3QuIYoDoiAGgfa+m8jplC2eBmE+XJ
 Bm6BY7AcW+xWq7a6hIU5VGh5b0ZGGzCF4E7BcyephvO//iuphqkacU4sYOIHIqdiAneiKB3rDVE
 OeiOk34XkwTkVYm+IgEW9Gcdkcc8s2Xc9lTyHzUdYl2jBmoWXKZntIj8vPYayUY49jXpPLiRo7f
 hG0qskMYg+LYAmKkRAJSkvta0Xhirr4VYgot/EmQdVY8Urua/xPe93epwFmtVxhj1p6FYxD6BmY
 Nsu0TwCuvCP82BmiR4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfXyhyGhylwpfeT
 OMaT8zUvj50K0Jtg/HH1ZgWgY992q/vt9JvQUKyGsLfgtavF6qEm0M3Do0YsUYmEddMGrp0skEu
 xUbzUucOPhq4Tx1dM+S8lTNYXOpzfcY=
X-Proofpoint-GUID: 15RMn6wtUlj6_Pa7C3zIy-X9ACf4vKph
X-Proofpoint-ORIG-GUID: 15RMn6wtUlj6_Pa7C3zIy-X9ACf4vKph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200010
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

Include exit-gunyah.config fragment to enable early hypervisor exit
on QCS615 platform, allowing U-Boot to run at EL2.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index ccc3bf24ab1..311e427eb66 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -4,6 +4,7 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
+#include "board/qualcomm/exit-gunyah.config"
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y

-- 
2.34.1


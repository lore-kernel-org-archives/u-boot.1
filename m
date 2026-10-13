Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207BDCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E8B480AAB;
	Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-vpkuv9Ke4A; Tue, 13 Oct 2026 05:33:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DF37808D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869583;
	b=KtyUtydv6MEJQpRPH9LQRYauq0zyNc5X4J7KsXPDf+OihIyvEeZdxd9uLgOiPXAnHurC
	 PcpqKP9xSh5mOHf2Ip21IiMb4HpMw4IGc/cA3nMfi8sjEKLiCup8oVkUh7n570PAxcD9m
	 2Zr0/VHuV7YWWNH7O/Y+fS1nUMc1mwpB4RKLJB7piIXyAm3plqWgPz+iAl6pmepEtclaJ
	 kKwK0xYsa6vLskG9q9VUH7g7OEj4Q/Xe9LTJXAlZaOTDrMyeo0nICzGBOZ/VmRefgpaX+
	 TpnYG07zrkmj/XOMMOfTsr3KXjPJNtVWL6wlgdHsEW76wSV3gCkm49hl27df5kgrMQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
	b=p9PgvIiPDKzAPQazfYK9DAktL9yiCKUzUKhql3g+KP0vx7Gvy+h0Ypmh+d8IAoqjOQw4
	 vpineo6sEMTo8EywRJUrGXFMUMIqv7Dpjbi9K8dFzoQ3HcOu2JoICThif8s5jCJFyxwp+
	 CO+Nay1RgI84KAWbVYhjgJqphR1iJ25UhXQIt4HzG445DxvNyw413kjk2MKNKkjdLyli0
	 jjteeOV0Z1oq6GpqVYLoyozmp7h4yB/l2NcleDSMGNCy4YvDZaVMZuApleaaMSqJRHkEX
	 HMpVwwnm7R4bqMpxfFIhYxmKe4xKsDoJE6vqLg0NzPAm634Ye3ipKTT97N80erSN30Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869583;
	bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYNiT2bng1+1FCZi/IjkowUNVfknIucN+vGd0fXZOc83SfjR7PUtraK8EraMSzbzS
	 R31bV0LmvNC8MbfQUvLgIhYAf8EUCROIvcFwCw+99G5wu4jMLat9iHg334d0A/1s1l
	 NaiPwdcH8Tqr0a7SEE/pAFu3TNMIALV6tuSmJRJ8TwaIApJy2J/5BPMd84w/KIZrQF
	 GID6aPlfWgpRoZFLCBmvNzDOocVvj6z4CA9neli3wgKtTXZu66Os7qPkx7CZbvCLII
	 HH7MQHgHOn4ksYmgEKaRvu+I4OUMegAf8YC8rPizHAUZqFkcm0koVDKRl+kMpsVxHq
	 u/rL23rrUtc2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DF37808D9;
	Tue, 13 Oct 2026 05:33:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5F41DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88D48405E6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jqj0XWopEZ-U for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A7E3405CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869580;
 b=cDCJ5X7J5XOe4TMX8x8sZT8bubAWM1tP9FE648Z3y48KMxVK45KgDkQkWRxdNykfh8I4
 6OSLaFnVOw+IPLkoj86uMON7QkgSnSdozH4PGuVg81uqNbLTvewiUTex0MGLe7b6GSBEG
 iuA1uWhLlq6qiE1jErz9WBpSiDDXIVztY/zR+M/4EHUhlYKs6PBlT9iOBwNcdN3IZSLgO
 udv26svh+XyNXwo66ILgbZXwvjC0KiA0c+7YEnax532PlD9OVNzQCSaaOt2w7mzPK7689
 TJ/BI3E19Ut6341G6GOd4KTmAleGgg+uZb7K1qe51bcPpXCR7ACXFu7LB7FX2V3sx5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869580;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=FKRyA6GRFghB80wlmnwYnzlhPKnWy0fR3+I6plVAYvtEfEjW1ADJiRW3IRinv/m05uOT
 Yjns2vqdjMC33WbZk5sdI+FTxIxbvBJg9Ltunwra1NmLx6TB1EuIevpxTGkrREaB+DbaP
 1CHWqQXubVbVT9NVC7jYIVG67eNh3zsoNQzwltEmg9xvIBQeeKsu9eiNujW2M2QfITPxl
 ZooYFjZqkxA6HusDnbY5dlYkpjH0fyPvp52iJqh/iaZYcLKPAgLa/ogJg5XsVhuqKG7mF
 mkOurKkiJ88kGvBMDMXdTPNG9zByiCy8iVID1xeQ4+G4NjDkmhXaky7zcNghWPMO7gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Tcl6EKgo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="fzNnS6G/"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tcl6EKgo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fzNnS6G/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A7E3405CE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20rvS302938
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=; b=Tcl6EKgof4levCBn
 ecTaWn3g6dMLnqMYO6EJSL06Heh2RBIYTlJ8hD2U5h2gnE8zEtqDE0x5jq96BxJ+
 7jmKFJBiXejwPZYHEJLgmVGaaK5lIf3Dvj2l36yh9kHy0jj6XEGwFIISzWHO2w72
 giRtAlQKFzfCOi/UQPjJX4xCTZ0jExRHUHt2JjNQGwFBRLFYFUNzKhXtwZnOrDdo
 TcFtAZH0aINwAYCc8bJRyci1unMJaKk1zaJTYxCx/BehoNWERDu7AACPcZqPn1Bk
 aIYT2SaE4rLApAtOE3HDVSzxtjdmgydsA+VRXGCauY+IPB0obeIrVjfNoFGKH4q2
 Lmzzug==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sq95qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso4221551eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869577; x=1792474377;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=fzNnS6G/PPQvYvI85CTWuuR8c6zBtg+UZIUXT28t8QnS61MnFPX0754L4SMxq6+4/g
 ttIdTCuguE+V/5LdKYtXYO36fSGNcS5vFuA9A4FtNUwbGQIut7N1S/3M+JupyHeElzkB
 fyuzb6UxG+6FN+MIeYbg+lU+DKBdnQelygtOPDAOkfSqyIahB8XdVhRReRQa0kql5+Qc
 sMvPa/1krfy8LPyalwUPL6id/YCipNIuert3PfiidC++LNewrPkcWkS0nDKf6h/TxZYI
 h+dKJOAkqSYPz99PS62BLbLpTiG7JRXh9DtYEn0JHTg5OtOMkIdq2L5FyKG3dw9FJMGH
 GdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869577; x=1792474377;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=pdNdTDtuxy5NVAMece2JKn1USJx7ymr+1EwJ27f7COooPFQhzASYbG12JE0DBFaKrA
 eGPld8F1CKpEc15ywZKLZZuzprfQsA4nxSXHzVPnCIeMIg+WyXf2fr8WC6D2IN+uC0R1
 xqy2KI2zKPWMdZpmb8mDy33twi+VYBYbro5dMM9Y29dej8Es0b+Fur/0zYLnhDqNxmVR
 dGaklda9coYKeBu00GOJg7E6YvrWPYhZLFUNaSgpEq8NVBgV2fxvCf1YoKnxmHQQIW6u
 y8V5cOZM1BJwfV/H0QqzcY48fWBp84qwDGk5Z5a94msEmvLdIQLylBpMLdEXVFVNUn90
 ghUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+7XynLAjdDkal7/8Zi4gtuKsnyUHCDbVJsgxFwZhuHeDzAdVL6Ver0ikJnASyraapi45R60E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJzuijQHGdhkjLv91Do5Pk5mEMYXEOuVe65QVaxyvFF4orSbdKz
 kGGL2NbQHwsNe9dmYxOngkgpuWqFrrJXB95LNWS+cUpXMZVnfDkkUoIfhjFTT50z6znbSBG9t5G
 /nYGtjCG2PZXFkRgEb74kTBfjU2bOTNP+kdmICSpM1AAOP6r8hKj7zG85JOj13A2k7lq2HPc=
X-Gm-Gg: AYBFou2kuEQV+eUXHpoqRuXYTcDoRl7gf4RPk5K6NWqpcgyDar0wR+aq1NUH/OSoD+B
 FOpEfS0CQ8RsT8RSQcgH3o3X9zaKEoytAAjx/z5ugmK04tzSgo4NY/VkjPa2YJ+d/dO/sFBnYyL
 U4K8vDLe4JBG5O1DN9OCiUa1uZ9Lvfi9QI3nYxkP8E8MouRP4SirTyySW6kVXh7W1I57Bbu8ZrI
 dO310204Zn7oYkfqiiLfOuL/z57UeHHIeLCdndtAGI832am4c8R4Z/7VYahDmlcSAP1uJRWGnWi
 i6UAnIE8QEt/7R7AIjwGoatOwxf23N7r2FOCO0oqQehRbhiNFNEVbfxsrTnEZsUh8dxL2K0hoUX
 oBufg0E8g6i0XBLMr06clp4Tn5c7OatgiibtztlqNxCI3Rww=
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3537df95584mr21578584eec.16.1791869576482; 
 Mon, 12 Oct 2026 22:32:56 -0700 (PDT)
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3537df95584mr21578546eec.16.1791869575872; 
 Mon, 12 Oct 2026 22:32:55 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:32:55 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 01/13] arm: qcom: add common QCLIB SPL extension helpers
Date: Mon, 12 Oct 2026 22:32:32 -0700
Message-Id: <20261013053244.2954876-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXyzwSJf6eMQBK
 JKds1Ngf9JXEcMoBCrriIiWlcBJ3lTAk3B2vqGYp0J+VAjXR54q4lxW05Q0o0F2y52G76RmvAqe
 OHisMI3PqVzCd76Apu5UJcCLSurZeIsKdXyfWCVmm1U7uRukY/RaWwOl1oKlu1AhJNYyfnmqdjb
 QpsRDqfrQ9tCEvEjK7y+JealH321fOYEOCaIT3rsIVSGYaro9CDe/CZc35xVLVWlp+O/KYK3H/K
 VHpManVYx/+XnPLq8eb6u6R7iGZpFmFypCLNXB0wyyee6GJKRm3pJmlXgOM48eDr0A1dRkL6nXs
 VvSSGMDSZLDbvZNKMz4tkwPmVhcizdHa77WBoXO+qaTDotLkuRcvAY9WUbRBggSVT0+Yo/n3ZZE
 jF1v9rwudvDWPt7PJhzuQcIQNewSOqEv5sZTjvfksXM5t0hGAQgrgFhIyzUMYQoSXC0EqgrWweg
 YKenp7iv5VVPoZXuPTA==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdc289 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mk6k_5ylc47UFE0K2zwA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX5Vra9xpjQ7kl
 l6i/8GAs4svX/AV6l9Pf8sJFvgLZ5AeUu1TuRFWg3w6OfBugE2GVju08/Q5ZbdkjQfOkhqz+apH
 YqZc2W5CyjPrSI5BiwiEymz9ueqqP6c=
X-Proofpoint-ORIG-GUID: FFxQap8q39DLFznMoCYRBZYnpwXH2N6b
X-Proofpoint-GUID: FFxQap8q39DLFznMoCYRBZYnpwXH2N6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          | 50 ++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/include/mach/spl.h   |  3 +
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 4 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..4e3b2527a7b 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -6,8 +6,11 @@
  */
 
 #include <asm/sections.h>
+#include <blk.h>
+#include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/err.h>
 #include <mach/qclib.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
@@ -27,6 +30,53 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
+/**
+ * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
+ * @descp: Set to the resolved block device on success.
+ *
+ * Maps the already-detected boot device to the uclass/devnum pair.
+ *
+ * Return: 0 on success, or a negative error code if the boot device is
+ * unsupported or its block device cannot be found.
+ */
+int qcom_spl_get_boot_blk_desc(struct blk_desc **descp)
+{
+	enum uclass_id uclass_id;
+	int devnum;
+
+	switch (spl_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+		uclass_id = UCLASS_MMC;
+		devnum = 0;
+		break;
+	case BOOT_DEVICE_MMC2:
+	case BOOT_DEVICE_MMC2_2:
+		uclass_id = UCLASS_MMC;
+		devnum = 1;
+		break;
+	case BOOT_DEVICE_UFS:
+		uclass_id = UCLASS_SCSI;
+		devnum = 0;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	*descp = blk_get_devnum_by_uclass_id(uclass_id, devnum);
+	if (!*descp)
+		return -ENODEV;
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index 50cc8dc4e8f..a32a85c48fd 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -6,8 +6,11 @@
 #ifndef __SPL_H__
 #define __SPL_H__
 
+struct blk_desc;
+
 void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
+int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1


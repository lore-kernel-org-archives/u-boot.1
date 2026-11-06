Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B270D606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GjefyEeB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c68LKI4v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kmQioyT9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D460408EE;
	Fri,  6 Nov 2026 09:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RhstLE0pHPFa; Fri,  6 Nov 2026 09:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DAEBA40959
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958189;
	b=ceNYwTdlfTZP26+uqqtaeeqvPFOUe8zaoXtykbB33a7qiOuCwsWg1EoqVg/au50luiir
	 yjpjWx0E4PzF29VjO0VFAapB1t33I/aNEDfzQhMySWH9rA/STQsB12bDoM6Kn3LGhGNs+
	 5lXqQqAwfPscKyAbkJtYEUciIneYBZXDxcngCzv1acZxRVo64VXj14OzJ8f4M+FkFkEy3
	 h43mxRj106SIaAPuHnx5ue8HrdAfXwX6BUsLyMfp4GAlCfXD5xTQTUVUQ1BXhgZwPu3Kl
	 Bz56tZ7nY//6ryfxJ59INgrnukwPaCOTr3qK9Jr8X5MYO5KxjKJa4F8mOqCP9ReVxcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UOjm7rnhFaCSh6UHl8ObWj5xUG4NQIPUcZo/MQgNhlA=;
	b=TYTNCB7QFhw0HIMQKohMxdoWydiL4qheFyhrNbzPZzl92y1kg3B8zOfb+ViWgknlCBiP
	 shkXmszQNNyT7uyDkESQYi0Q0i7uJGzXQYL4UMC2Z8ksCGJgfHK3r5F+vz9hKos6G4VBg
	 aTEtJ4rCs3FXNeLaXx436UbD8xIGcW8WjuqgneIjAg5nYXSXSwFQr44JGMurVe583a3rX
	 QVGKzNTsfw5CeAiLRrnYRwsiesIv3IuC0z2COtucJn5FWqAlZ3Coh79rbAcl1dXO1Zq04
	 iFpuhb6afMQ076zvgDTKeq/f487CmNbOOO2OzQ+DQB+WSmXtLRexkcis65Kk1yCVX1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958189;
	bh=UOjm7rnhFaCSh6UHl8ObWj5xUG4NQIPUcZo/MQgNhlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjefyEeBoDtYAcuuX/wjn0FzoD1M93VkVT5MQIeuLnkcnDQjjKU/jtYwCpdSr64Nw
	 URSsXvsX88l+0SbBq542HVjWDU0GY7oZybHRvArCJUGVfJWGj8AbC5omkKh/PKbbcO
	 RQVvERK8aDdrfUhw8R1S2OSyKgzNCkLbV+Q4ANLXJzprekhyuyHEhqUsjdIqCng4W1
	 hvF0bBwoUD8Ezci1kWv913LIB63kWkeusPHv8uGtRRP66WxY9Q3jeip5wkLXmvalz/
	 Rf+cqRDGf7bJ9oR9g9+hm3rCJQB1hxqOL3HTvOksJ0ewGdMp+FcKuE8CZKX8vZ1w6+
	 KfmxNbJrl3O7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAEBA40959;
	Fri,  6 Nov 2026 09:43:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AEE32AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D525403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QAelTD92h7KX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BD55C403A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=c68LKI4v; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kmQioyT9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD55C403A8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RBf1045288
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UOjm7rnhFaCSh6UHl8ObWj5xUG4NQIPUcZo/MQgNhlA=; b=c68LKI4vMEw/RWen
 EMMa8J5YfJ9ag4Kd/wI5VZt9Anymzuzuf08MwyDOrncVRbEBbleJwcZnkqAiDFNU
 rzoOnw2w5Ar+AJH7I4JO2nbHHHpmgFDnRd4dUZMpVO5EM6W8g6DBlFszjrdU5TQt
 rjtmXF0vuofhGBsXzWHT6ApWqlH9U+UzQ1+AC5xsHyFv2njZ9FPs60GG7S9yi60G
 yYyXOyNbXHX2kAOCLs/gPOKf/3/SbNPIUVrDhm8Tqi8fFFCOqVZFzM+YjAATAClh
 XlP3VhE6eVycx0XLqbrlCxeLR3Ig+jqEuhslyEAzpbkkkTr4Nteva6ZDFgH2D6FX
 rhHiuA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t6yt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f3969a2a7so82835185a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958184; x=1794562984;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOjm7rnhFaCSh6UHl8ObWj5xUG4NQIPUcZo/MQgNhlA=;
 b=kmQioyT9qm2sSoYBvDi80N9Zg5odH2T0DvQaC3zsHBucQvl9FImIZHCdg0gqQAgnrW
 WSiqhnkvJdffvoTf3Y7iK5npBeG0WjTyeEdpnexeiwei0zKsmus1+mlHsEbyORFwdsOQ
 /mh8b/+E8o4GEaddijQZYfEe+tDuC9Hyd+AK6rvdBIgvcakwnkQqBGW8l5GDTVLoMHS+
 30I0c795DUmlIgycnE9eKOp5mFJNUSjd10BHFlCVJ1tbFovFZmkQcDjjzWpqTLiH2hbX
 5YSjt+o69/zOpCwqJ6HddNSYsfzlujVzkg1s4E8rd8pOiZBVokTLzhN1SlajxgIgWYkh
 fsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958184; x=1794562984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UOjm7rnhFaCSh6UHl8ObWj5xUG4NQIPUcZo/MQgNhlA=;
 b=ajFKv5PIj6HW3f4cqvYJmUq8hQrHQRpiisdwOVB3RPmwJOz8GAMJ0rZpbm3Nq/KmDI
 DKYknq4Fplk/8s14ZHXtYefpOL7bNYI9KBgFn0C0vGE2ls7Wx9ufsTk8rD3EcfyplMqj
 pCtKb9oCiivkfIPVWYD+RC7kcHhnmns0HqULlg+fCgnbRVQgyA5fevy0I451KBO//Tqr
 S2E9hM6j9eSA8h0N3h5rplTDQB9RWPyiCwfFmvW2l9WZx3nfBTxeV89B6h0xu7TdLe2l
 c03wFQxkXh+sf3h0gi1+B5IIzPF91ufkjB1J/yVnfRyS4MDnhhR2YsyGf9DZersFmSye
 bOqg==
X-Gm-Message-State: APuU4Z/TkYx0EeaQOAi6cb7uhFzufP1HU3EtsHBrPppI0g6CuMurETs0
 OpIMMSC5Xz8krfjKgbAnBmc5rOIaEC7cgjTE58Y7G37fT20+mFgEmq1rlJX4Ej4HeIW2UU7DI+n
 uvfAIcWN9ZFaTqhcAUkna6h7K8uP6kFgp+mmJUaZjnYN2axryq9E9F3W2aP7Y8tgXf+2fO/E=
X-Gm-Gg: AYBFou0OFFkAwV+cFefX7kow1+8y1Wq3HO2YXrYGS61iUEEvKnL2fGRMWJeyDh8KUjq
 6MybEEKl6XW4un3OcEO/dGKoElmuLJK2ALQDoHQPJAqzcq5Heu8yEzopyMa4NDGen09SKwgVaXl
 Ox+BGVZebmr/BF8AxjkkE5Ciq3d/ZDpsHMVHr5hpy5Y28OuuDCLpj8iLhGVJvbK6YwD+/nNvfEl
 /EBXq1DAqix4RKtQ1hc/f3u97xScfN3k09L2kkc/3FOOJFvlOfd7JVIpEAnqfuNzNN5+JvtlUPn
 iTlMBmFtGCpQgvVrBZ94kUEqHrbunb8EJ9NlA+6WQ1kbfQySWiWZL9f+ZJ/F7V0F78UcycFHXyi
 7rafRN264wOGVMu30GzGHhRQmlDuny3vKYlbbl3pOeLQlpKE88aAf0WOvsKb9ll8J6k/0FrpUPp
 zoPABAgPF89tqq
X-Received: by 2002:a05:620a:2686:b0:93f:643f:4f5b with SMTP id
 af79cd13be357-945f3530f73mr269138085a.48.1793958183882; 
 Fri, 06 Nov 2026 01:43:03 -0800 (PST)
X-Received: by 2002:a05:620a:2686:b0:93f:643f:4f5b with SMTP id
 af79cd13be357-945f3530f73mr269135085a.48.1793958183383; 
 Fri, 06 Nov 2026 01:43:03 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:02 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:36 +0100
Subject: [PATCH 04/14] usb: gadget: firehose: add the erase command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-4-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX4/yWXFzCYm2p
 l/O1cq4JbIldvGYBkIFSL8FU1NSaZWI5qVq7D9AyFpCw4a3RVj7+gS02BlpV3aZw5BDV9jlpj6B
 2isBRyTIlXzuRp6TIEM1YKWRDWwCbUQ=
X-Proofpoint-GUID: Vjm3j3vN-Hf-x3VhBkxzqj6aMsOtu4R3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX1aS2qHpDmTas
 64XaFMpGLu0PtGMotpsaRCVYf8tsQuHSMLifPDXao6dwsBckMo46vewIMCfT6KtF0N7QC0flKHj
 6HYYiTQtVQPZ3oVBOIjwq79/ChwDeGTBHWJyXnRGF2q3y/ejbAyp/fLmkmEFH4HMx7WgrM0r53m
 f6In2H8saj9J2EXeqiS9sviW8LS0NQH7SQLgeynQhH0HGXaEBROdxO18+/hj9e408QEB27E7qnO
 8bcgZc6X8vCmXQjovVpTdSyDcjzKjRSnWS92nznswnWqf9ICwuWKyS3vlYm86zh24kB2LBTBJMw
 iVbsKkdiKk+YkP4C+GO+ydRjoVrWExrHA2JYGe4j6vvwkKYltQxA4g1G8uXtqMLAinfGfuqVIH9
 wTOa1nJlhizVcsdH/pq9SzQJA50oaLmxfxFaMupQJQplDJYOy7jgjQE0eudQUqBaOFttkvGZfyZ
 xQxDHMqWU73jpWHBnWw==
X-Proofpoint-ORIG-GUID: Vjm3j3vN-Hf-x3VhBkxzqj6aMsOtu4R3
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aeda128 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9tIcQwgTbEAAbAi1x2IA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Erase a sector range, or the whole device without one.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/f_firehose.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
index 5f1a4254436..5f36f0ea8e3 100644
--- a/drivers/usb/gadget/f_firehose.c
+++ b/drivers/usb/gadget/f_firehose.c
@@ -622,6 +622,29 @@ static int fh_read(struct f_firehose *fh, struct firehose_cmd *cmd)
 	return err;
 }
 
+static int fh_erase(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	struct blk_desc *desc = fh->desc;
+	lbaint_t start = 0, num = desc->lba;
+	int ret;
+
+	/* Without a sector range the whole physical partition is erased */
+	if (firehose_attr(cmd, "start_sector") ||
+	    firehose_attr(cmd, "num_partition_sectors"))
+		ret = fh_get_range(fh, cmd, &start, &num);
+	else
+		ret = fh_check_partition(fh, cmd);
+	if (ret)
+		return ret;
+
+	if (num && blk_derase(desc, start, num) != num) {
+		fh_log(fh, true, "erase failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
 {
 	const char *value = firehose_attr(cmd, "value");
@@ -648,6 +671,7 @@ static const struct {
 	{ "configure", fh_configure },
 	{ "program", fh_program },
 	{ "read", fh_read },
+	{ "erase", fh_erase },
 	{ "power", fh_power },
 	{ "nop", fh_nop },
 };

-- 
2.53.0


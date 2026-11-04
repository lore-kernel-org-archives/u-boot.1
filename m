Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3B606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ApT9pLp/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JO2wlZG+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XVTnAQdg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5469380C8B;
	Wed,  4 Nov 2026 16:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tijBFfSlQ8DI; Wed,  4 Nov 2026 16:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77A4A80A55
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810093;
	b=WlqJBimsjpovf/nX5/o8zPptmRg/vqle2b+xYM+3/VydW4sJc1SllbEtC2f+FyAoc6kQ
	 HlsGoMHCv8SX13XkIQxjri6JkXTY6LPRxxLxo2ULDkQU60M7UO1How6YYPymaG0L9nvcg
	 UtQHuKaiS7HsJTdCLXeSnqv8jtvLkcqze6JkOjbaMNM7Z+QzsJwFGaywT13KLHjPkqRwE
	 aFGeeMl7rLCIfVAhWH7cqI8g98QkLL3tqYa6PkcGvaxpOlzI2LuFRfc/2U01T65M1bp5B
	 J5PL5iY0wgZKM0lip0c++NUct6mZyOvJYdjLVVXjgG/qe31W/iFaIQSTJgjlbOzLNaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BtZfOBjvm0xHf1GhRwEc4VfKNQ3qHmDBawMkS4kuU5M=;
	b=jh+c+Elvrbyp5RRGtiaL7Xphzj0OH+m5rOJhrAlUDwboRhDUXe9CElJw08ttcGQGndCv
	 QMfl40UOSo8akngWrBqYBIaqts/PXPDYCC9H6XLGxL6w8lqsb/5kQV5pFHN+ButtsllL1
	 3DDJdn77+9qwOOCJBwpBPI9nYSktgEwDdFlVYUozvAK5VcgyVKyL9X4Zu8MaoM2KtP5wH
	 NnimASJLMjd0bHtXYHUkidYxg3FKhlCFD7xiQjtEv/82kEqN5J6mYeHAL6qYVpE5N38dX
	 e/fAt33e1GKa3qiVKwstmpwUwNc0czFXhgag3hD7UDnIyydI/YcUzEvxSQ1FEy6ur8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810093;
	bh=BtZfOBjvm0xHf1GhRwEc4VfKNQ3qHmDBawMkS4kuU5M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ApT9pLp/AtubvZDS1i6UZ7oIFS5r3P+U1cgJbhzoK6m4IaqMwhjb967pYsZNd166p
	 FJobMuFW42agfl/DTf1tKHaLTkIhbpHcBU0Uxtjebgv4u36gVfs19dmXFYjlvVkGQu
	 OzMCiOc6qMgk6R+6gYSlfHy2h1DGgPNFPok55OpGaHMErX1kIQahGPEuWVD7OA64Mj
	 M4hUvopT6GHeNt+WiYmOkML2kpJmrKhJT7RC63VK0pofm4uD8P9C+CoXKNoP3VbC3f
	 /n0joON/DeSYtKJKgOYDsgb1RAZHKtcriBNlmI3T+5iPMGW9oGkEwIwQ6+ejerolRa
	 UbPCLxXrgs0mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77A4A80A55;
	Wed,  4 Nov 2026 16:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7D8A411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD99760650
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scOfOx-Zpz7V for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B068605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JO2wlZG+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XVTnAQdg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B068605DF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjC4q2251557
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BtZfOBjvm0x
 Hf1GhRwEc4VfKNQ3qHmDBawMkS4kuU5M=; b=JO2wlZG+XBLdhzLgxsM6sTeZdoI
 58MqH+AV6+FwsOq3ysbDL0w2vTgAaVy7R2bt9G09TdeStITEtLDAJVJb1tLyMjx0
 pCy3WTw/SP1tQZV5fjySKDd6KyK3Jky3zYTDmdDbv0KffjOimQU7YSNHmHi+44qv
 UpIh883yh599GAdwJ95HWD8S/o++otJs+8c7oEST8OUA6byAaiyLtHFHMkLPsz9b
 G1gnwzSRO5/KCICKlsVbV55g8V3vaQUXmVg0IwmBBAI0U1lSgrRKBYlh8/l7zV1d
 cF5A/VX6AZWGLKmxOD41oI0yBZW6i9/qHmndpbK1p4wx85S2tF/pqNA+KEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn13ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:34:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36cec75d8caso838026eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810088; x=1794414888;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BtZfOBjvm0xHf1GhRwEc4VfKNQ3qHmDBawMkS4kuU5M=;
 b=XVTnAQdg83zFpwqqyh3Q+urUeVpevLryTr6w60zEF1GfMnOHJwzpV2vseBZL2d3Jx2
 24BzcE0Ss8wjpZjZp5CODRaIzYdkyHWBGmRnrEOBRORKd/nuO74NDB9YLY2jtJ475Oi5
 dM64vV5XVACXbAd/70DNvOEGNF+JOUCeTDY8qvz83q8AC7KC8IZS/gf4VCLsfZQpbnTk
 WrWTDpfosfaM4xYYzzgHqyUK8MV7GFjt1ZsaXSt6l+Ed7xE9T51E3yE4dtGIAb47ojOT
 nBDdIffii/4I7614TKz+zrvhpW7xIOZq2PJJKiC9n1NjMh5wAXxlbf+rblUazGqWK4vP
 argw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810088; x=1794414888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BtZfOBjvm0xHf1GhRwEc4VfKNQ3qHmDBawMkS4kuU5M=;
 b=Se/4cBhTtlzH+/c/PQZlHD0TPoTAyHZ/vsqxE3ZGE/wQv+9iUx0h3iSsbVcvtBgH7k
 UMasLwa9aXs8re7H64uA1Z4iU5ljwRw00n1ebiolBdIs3U6MIrGh1Z/+o546o9L1VB01
 mlwyST6eDNLG45h+ENJprK9BBjds8FpG6uLPfmnpLNKDrHrdGlW7FVy2cK4+4nWtRh/V
 H19E5wxR8VIy1pCMZwLmC40KJ5QsC5ZWNHBpbv7FYq42E5ckv+RTNSS4rriiUPkC+HOn
 LMFTvVPorTdGPaoP07dQFHrilaq/60eORI99v/pkpaoeEL6PjjA8vw6NHLX7g7XHH14t
 hT9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEhQsDdLTeX0yRikboh69BXBZXF4JDS5y+RBy4Rb9XcpZQvOxXaaaeaoXJsswwrUnLQGPqcnc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9BR5fBTWR/+wG5XqPPa6WbIFzOmzD55vI5yxYIydP0QphvAg19
 /BS8Yo/iFoRPnXLXECcwvfaZDFGDS24gI9MoAupsRrjm1IcdFQ0dYX81aQx8OMtOlS88MkygaoQ
 GUWYgvMrrOMXgVOvtv02ildzPbzA8X0DgQzFYv8YqSx4ECGJ9OE29dHrkblSJ+3bs/UlbAsah2y
 EOZNk=
X-Gm-Gg: AYBFou3u0oLcs4pdbyii9MAqMdNoVx1NcfTpnjGNpQfOawQoD4l/x/vkrIo8o7n4PpY
 K2mwYnP83/9e+RkrhFz/W10msz1PlbEM4M6a9+zLynB/E9T/I+8L+Hx7ygR60O9VBTqmyhpp189
 bpbMjGYcacA7Hj9/DeUW1eu8CdDsomYtZM2iN90dPH2ohh5KwJdX5kUxeFGd4kHWnPVj7LeAGg9
 CqaqhY1TwEouuAqt8qD7SozfVkv4K8tI6UKbBGOy+X9pU/qNhXTCPXbqIdK8hDbMXznSVBk1Dn3
 uRKrx+EuTsMQrGdBo60FZOxfvujBLhEr86UXqgp7eGknlBTshiq2ORuMRYh2gKBALuY184jQyNe
 EPgFhBuwqfVzqWrCkCLarGAiK9nenmBj8ZLJI5CkmMFPofpMd/Aeh6maj6e/Qy4t099wlW0UUmU
 5emEykQLmbwbw1J5ROVX4ugWY8RWer2Z0uy8Rwal++8mNKP/ICp1AXP9Tzmm95ifI+
X-Received: by 2002:a05:693c:41c5:20b0:369:f17d:efb with SMTP id
 5a478bee46e88-36de655f12fmr4045eec.10.1793810088149; 
 Wed, 04 Nov 2026 08:34:48 -0800 (PST)
X-Received: by 2002:a05:693c:41c5:20b0:369:f17d:efb with SMTP id
 5a478bee46e88-36de655f12fmr3978eec.10.1793810087237; 
 Wed, 04 Nov 2026 08:34:47 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:45 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/9] pci: pcie_dw_qcom: program PARF DBI/ATU base address
 registers
Date: Wed,  4 Nov 2026 22:03:52 +0530
Message-ID: <20261104163408.1250410-4-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXz3St660yOLPQ
 V7EZHnj/petn0XCHaIT04A1h/eQa11VWgDBY9KxGib3deWnO7e8qtR4iWqIH82L3g/kMpRdMOeX
 dhkpa1JdJL1GTS+I5iLHjIFB8MuInllfQD3Bw7SkiiEfC4OFYpCmCLv1ai12m/8BBP4wtNDwz3J
 et7Yfd5cNHYGJrOrVV1IZcmzAg3itf3zYfCHBSxI0+/1wdDYyhHEegErsMMJiUxKBBL+bLD0C96
 OaliXU56dC23EZhUsswQ+QbRsoRD5b0nMMBFN8WOROL5InKuy1lRgGhfJXRQ1e0gVk4BzkYG6aB
 xtPX3CXIekaYgUSO/Pk/ukbP6CO71arIAbb79WIYniZOFVDmyQ5MP52keBFCI2Dv84YDAwSWMne
 LY1WB410z57E4pUPjUX/J2eOl4OlBSpR2zqcbioSfq/AjYgQK5psta6wKJ/oHBQO7ABoqiA6hXa
 Y7AR1FETPam15qvCa/Q==
X-Proofpoint-GUID: tFwWwJ0vpZS5aOFASIkzdU__UaP8ffNf
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb5ea9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=IHYlreO90MXzq0s2gkwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXy9l8kGK03p7f
 t0ODvyHxUELCZPpRSTtvPYV6Urr/eru40EgpC9FZAYLTxSX/og9BR8JQsuXWZ4Z8MaOCzN8e6aH
 kf5nDSZGGenu9eJRnp5zjkM75cDdmh8=
X-Proofpoint-ORIG-GUID: tFwWwJ0vpZS5aOFASIkzdU__UaP8ffNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

The V2 DBI/ATU base address and slave-address-space-size PARF
registers remain unprogrammed and retain their hardware-reset
default of 0.

Program these registers so the RC's internal routing logic knows the
location of its DBI/ATU register blocks, matching Linux's
qcom_pcie_configure_dbi_atu_base() implementation for
IP revision 1_9_0.

Also, remove the unused legacy PARF_DBI_BASE_ADDR and
PARF_SLV_ADDR_SPACE_SIZE which are not required for IP revision 1_9_0.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_qcom.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 1215346bcb4..dbcdc82224f 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/bitfield.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 
 #include "pcie_dw_common.h"
@@ -49,7 +50,6 @@ struct qcom_pcie {
 #define PARF_PHY_CTRL				0x40
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
-#define PARF_DBI_BASE_ADDR			0x168
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -57,7 +57,12 @@ struct qcom_pcie {
 #define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DBI_BASE_ADDR_V2			0x350
+#define PARF_DBI_BASE_ADDR_V2_HI		0x354
+#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
+#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
+#define PARF_ATU_BASE_ADDR			0x634
+#define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 
@@ -111,8 +116,8 @@ struct qcom_pcie {
 /* PARF_CONFIG_BITS register fields */
 #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
-/* PARF_SLV_ADDR_SPACE_SIZE register value */
-#define SLV_ADDR_SPACE_SZ			0x10000000
+/* PARF_SLV_ADDR_SPACE_SIZE_V2/_HI register value (64-bit pair, matches Linux) */
+#define SLV_ADDR_SPACE_SZ_V2_HI			0x80000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -298,6 +303,7 @@ static int qcom_pcie_init_port(struct udevice *dev)
 	struct qcom_pcie *priv = dev_get_priv(dev);
 	int vreg, ret;
 	u32 val;
+	u64 dbi_phys, atu_phys;
 
 	dm_gpio_set_value(&priv->rst_gpio, 1);
 	udelay(PERST_DELAY_US);
@@ -346,8 +352,16 @@ static int qcom_pcie_init_port(struct udevice *dev)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, priv->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, priv->parf + PARF_DBI_BASE_ADDR);
+	/* Tell the RC where its DBI/ATU blocks live, and size the slave address space */
+	dbi_phys = (u64)(uintptr_t)priv->dw.dbi_base;
+	atu_phys = (u64)(uintptr_t)priv->dw.atu_base;
+
+	writel(lower_32_bits(dbi_phys), priv->parf + PARF_DBI_BASE_ADDR_V2);
+	writel(upper_32_bits(dbi_phys), priv->parf + PARF_DBI_BASE_ADDR_V2_HI);
+	writel(lower_32_bits(atu_phys), priv->parf + PARF_ATU_BASE_ADDR);
+	writel(upper_32_bits(atu_phys), priv->parf + PARF_ATU_BASE_ADDR_HI);
+	writel(0x0, priv->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
+	writel(SLV_ADDR_SPACE_SZ_V2_HI, priv->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(priv->parf + PARF_SYS_CTRL);
-- 
2.55.0


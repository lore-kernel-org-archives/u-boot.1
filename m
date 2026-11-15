Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F51606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oz3FuazT;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YxL9tvdf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJrifjGn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33984607B4;
	Sun, 15 Nov 2026 19:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdER39zifGiu; Sun, 15 Nov 2026 19:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39035607F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769255;
	b=ccuW7s9hp02slKhcPE4fgku8tWDfzvsBhI5TWNIkJG/YftkVRE+JflUb4AFdmkWjZ974
	 U2DkF204qdYexuZlstIkhzea5wiW5EiTd9jjsusmIBBva7rNkpprxc7lEHEub129bVWEF
	 iWP5eV7AZgdpwCkZs2ZtkSuyAs6GiHL3KOL4Qa26re0MmXqpXQVHxBc8EcbFPAdKa+jkK
	 r7B56MkrcF0IdyTC928ULoONFDuRotHulL9893Qfbi4pYhAYynhmlQ8p+vI/9Np6PTDuL
	 59/tKlFL1n9JGFcT+NaKr+Zn6hWFFnWl6lv3pzJowLh2rgF2gS0V7BRxoSXXB9xjgVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TodVdEjW7Tjcn1uUtVBlHScxZb+ofhHN3javFRWr+bU=;
	b=bAYy7CBmZcDJicY6QiTiIRvA1T5FqgKqMLg0OKgPwHM5Xf5GeX4OK/dFiG7mQ31Z27eM
	 jf7gH0EFQKk5TGab34tUTlXF3JXvD97pKcUBxbMc5M7HcUTwKMzQmaHe0rmA6moNmzzaW
	 Drr7C/2gX9sDu9Dj9p16HYqXv+g8zLNWjP4B0NDMJBmqOh6nfi9UFG4oNd1zkiMzD1lhB
	 TQh9zwP9ml6uXDxp0vA1lIaxZ25HuHm61P4xvhBb6QwybuuFUniVqtCpg128HPgiqV/Kc
	 rdaImRYKpCRJMyv06WHKjJaqusm2w5qpm/X40IL0fRkxp6TQC/eS9Q/eOH7zsNt/ZXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769255;
	bh=TodVdEjW7Tjcn1uUtVBlHScxZb+ofhHN3javFRWr+bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oz3FuazTFr8/uDt6PghrL/4f5CpoOnjwcfGw+O+N542OuIytJ8oWz4OZFJiGNLh54
	 DOfr9zRwc2Fgsc6Sim/9jtN+JHCqUz9uieprd4fqNlOR5r/FpNFy+TjrmOYH+/Py5S
	 g/Fyca61oN7p3ZVZwRqr8VtXuYvC6lJtOlsW1T47A14sL95ubCW/aK5ntTi3tUQQz/
	 peh0/e2upyZ7+x0a5rfsBDjyTledsQkZZjQqGZnrMt0N77fvgGpkISsSJ5bdOs3gi1
	 oLBejaNhbhWuk84tEj8lsjDjjKD2gvbvsojZfy8x97Iqwf0+B65g/zyeAnDsdJ2eDd
	 tMjX5Qkdv/xVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39035607F0;
	Sun, 15 Nov 2026 19:00:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5F5B2FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABC5280E9C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8TknUZHvZzp for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12CBE80E86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YxL9tvdf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gJrifjGn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12CBE80E86
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFBEfx3219234
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TodVdEjW7Tj
 cn1uUtVBlHScxZb+ofhHN3javFRWr+bU=; b=YxL9tvdfNsDfgbKe0fyBgQEmR/e
 7aMN9I02mQXzQJ/dUynokmB0mZFJrkJUlBcR8N1TOFKhaS1WZZG9brFbQpZo1HaQ
 9W4TrvDoQ/IXJ0AFVlfXqjWshwUu9/B6WiAvkHtiO3K17hT1PKqvIBeuMwU1nu/t
 TCKUUZ/G+OYnbDwpmkfBHzOeDpVzRFsvG0PTLHESQb+o9qS8uWMNsA7LseAg0ahw
 s+tJ4rVRWJuMgIp0wBK3NWshrfeM/6nSRaG+aYsmVWQrAMoL1arh78csiKvwmYO9
 GBaCQEjLouSJNWHuzFqz1vF2C1ff7c02/XHJVE1N6HlApsVjYz6DoWykYPw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqkjhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3458670eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766845; x=1795371645;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TodVdEjW7Tjcn1uUtVBlHScxZb+ofhHN3javFRWr+bU=;
 b=gJrifjGnLjqb84mjanOQsRpGDJQaPNilYL9DIZeLFH6Ijeqn6TVSHSEFHC7rRLL3FZ
 qkACWEqag7Eb/IVPuMYqLHfYxpPYi2J7utWb+gvfrIDVjqd4yrW97uxvef/8vLjbXFuk
 c+JUAoPOZs/dbR9j1Rt1o9gBwY0NFL3oCUMjDn3jrIm6twwAZuMZQqFPzq3O7oFoEs3e
 mnPVLXXzDiSmJWmKVra8kOysXUylPqMvENY0087+9EuoZjkxBXGQb0kh6IoQUjB6NnHA
 n4/IdMYwkpnUgQ9pYXc+FfpxbyfFl3XAIB+gcpCvUp1IqeJB+zR/WKlrb8DqWYxp2NrC
 nbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766845; x=1795371645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TodVdEjW7Tjcn1uUtVBlHScxZb+ofhHN3javFRWr+bU=;
 b=vsOUJU8r/dKF+IWBhjVfA9/4eTr5QguahbS73EMdx+YZClXZCYfXZYaCcQI+71/ZpW
 pUL7BVwdUl8BvRhceuf9WLFPtpKLfMcl7le5Gg5VwXHlmscQUzpDvTFtTBkuLDv6xyR5
 WbRvTX7pdpILLyR4dtbFPOBe1BSNatnpy1rV4tW1lsJr3o1TcieVrdQUdmCglrsmBpTR
 SEpqWdYGkK/0q3iX8zRPf+u2g7KNOXjTilKZzB83Ap9Gpb8VaHKtQmONISTF4J6pSydX
 CfvUGhSYovwKXu7kryXGT9UCfuTQEfxkS5eeuCc1IAXIn4xg+f5CMX0Sf40hTrL1/u8I
 oC7g==
X-Forwarded-Encrypted: i=1;
 AL+hErFUKMm5ef3wh2+zk9ym+S8Q9Pb7vZoZLqavVST9njmFyI3aKO264ZzyAcoRK4OJsG9FlnO8ITw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z80G9UY/tb2UUeSKHTqrEYlFey05mTsJeT2ieGCrZvj9txt+4Y0
 vuVcNwKvwxnRvK+mkkRoJaaRmql8ChgUXxKeUc/M+dqbIOJ1Ty9e3ZLngWPjDmtfEPumsLcVOcu
 pzDMtZbInO0Ui0AyQ2FTu7OAk57cOjpfyR/AobqrsM/Mfq8v11RgyshXRCF13pCS25zv5V/8=
X-Gm-Gg: AYBFou3nM7mYUm7bGUUJM5Fqbnw1q6r7H5kBBu7ksuSNFmlI7/DfKCyGwrPErF1UW3l
 2aKFSHqS5nr4kPDx1hHpVyzchz/9qMhG6Yx4hkC79qS+tj5s7XZ8CYNiA3ddxGDXGaHnxT2IMor
 r25nWDNjCspaJiGqZmiC+daug7VQLWsnPTXYVKdcysoJ6ib9qxFkHuh6+9y1CsWqeAOpU70pcqH
 8mBsadC04qWCZwz0VVlWTag7iY5d8dGo10V3RI0wy7RyCrn6P+PSBvabvcFkRp6XLfLXEkyU5qn
 tShBugDujS6mNdzaW9QyUqZzXNsXUwgBBHyQs1IOYZU60vMyiY3uvSHU7UC1fpDXefRF0+QxmVj
 oz0VTVDQmcF9whhAqSw4Cf7tDSh58N+3B0gfKmizfsNXU4oWl71Ulh851oWIu7Tae3V2ff341U1
 Ct
X-Received: by 2002:a05:693c:2808:b0:36d:f004:ae6e with SMTP id
 5a478bee46e88-3796721cff0mr7921059eec.34.1794766845153; 
 Sun, 15 Nov 2026 10:20:45 -0800 (PST)
X-Received: by 2002:a05:693c:2808:b0:36d:f004:ae6e with SMTP id
 5a478bee46e88-3796721cff0mr7921030eec.34.1794766844647; 
 Sun, 15 Nov 2026 10:20:44 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:20:44 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 6/6] clk: qcom: sa8775p: add SGMI reference clock
Date: Sun, 15 Nov 2026 23:49:36 +0530
Message-Id: <20261115181936.1750625-7-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jYtbKcG0g4jr8PyZbFaPGAowVcqVU_5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MyBTYWx0ZWRfX32rGGl5DlWas
 Yd7IfDUuvQ+nfM+QRcUoTultfLxMPOFgnEyUuO7NDImUShlrq5BQ052pm5UpgbKj1nOzgoe+MMK
 VbwKfO3kvvCr8w2hDggkZX5zj9jsZIpvYY9ubI3jMp8G6WIWabL4KxZf/ZffoGt40Ol9iVO24TE
 3spLqSu4i2PNE5cHGR9G/FUt5sHvHG97W55x/z2ROSA+ETYiGCJbv5KETjndJBhKvafpBcnnohI
 Hu0GcMGac8ilHcno/X2RO3nKVKzl7gTYehH86THtVZDMinstcbFWIRCAnaf82Nss4Pt+iVaa6EP
 SQeauQk8dhdGCa9WYtUCB0q5gSydVh67xPcvOluu3Wbxc2Fbpoq6J4tYtHyTfjXGHNznf+lJ712
 A4dznXnE7jZ8sPibZxB2CWh5ZULfo7xh+5FR8F8tewkmQyNBtjejb3sce5GlnCl9T/QnFplAOcl
 8AZeB0nlgklKkvpTJxQ==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af9f7fd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=IoVRvUdfyb1E_kjjjxgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: jYtbKcG0g4jr8PyZbFaPGAowVcqVU_5M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MyBTYWx0ZWRfX6i98/pVf95YN
 f25rA88rIsH1BEdGo+rkaVgX5CsXnfFUGW3v58AR0ELvLSFDVgELZVAZbMMprvWM+Ny3GSc9q1S
 aIna7PNCkfaLfpAoISMUNc+BqA33MQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150073
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index fd495b73635..65f8bd42a15 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -227,8 +227,9 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
 	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
 
-	/* EDP reference clock (used by UFS PHY) */
+	/* Reference clocks */
 	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x9c034, BIT(0)),
 
 	/* SDCC1 clocks */
 	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
-- 
2.34.1


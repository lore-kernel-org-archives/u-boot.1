Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EA606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k3RaGJaW;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c11c2IfS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnTJLNlh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4034940ACA;
	Thu, 12 Nov 2026 06:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8GKvrMZyzehZ; Thu, 12 Nov 2026 06:45:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A1AD409AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794465903;
	b=odwVdpASwCNAnZ4aiDO3vUT5spTtHqHJ2sPsGob9izqeWp0sWGfgBrJITlOBdbzEgPq0
	 oDbEFy8X7fdQA9VYGFMzJLMoySpOFUSnncGJLHCfSV8h3l6xbW+zPN93PlWi3TObMHrUE
	 L2AuTA+3rZVaNcXyW1SWjQkltoysz0RzF+8UrhvGSKcgSnZMMw/7bfibWHWLebFPNPlfd
	 iD/+XORtaoWbjpndsN+cN0ZR2m2sQBkfvI39LadRq1heXrQIx83E1Slz07dvNRIH+mwxP
	 7XcloYVq2enyrhFSpyPHQm7ga6q/edQLc/tELQeErhS6j/HKihZdZoVLxkYwQ6MDJ+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794465903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:X-Google-Original-From:Date:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/kYvCMxk+iKPsp+crhPWOZQehuKb5awab4IH1mh/wnY=;
	b=JCmzNP033YkDEXbmP47erQEr7LEvl9ASPVm3CRpYMqNs/bElXhbTcv5HR2ZuHjshTnLB
	 BCJDBpY2tv+b/EJa6nW57crGDzoxiIFOZXjby2vVnHDBkn+pDUSDeD6xnklZdEwh78pn/
	 8WVe4UkgsttfYC4pKTj+FSUhjfUmBwuJa3T8LeJJI1G+I5Xs7rQFBAk9KQLE52PPhTcIb
	 LomtIrFnRg5RrQmoXquWR7d/B6mv2YgO+KLBLyDbnAy6hX8f5ZMALADj7kxliumXk1uKS
	 KduFd7ZAoJOy1EUsuMZm4C55zrm3W2knqii6kf+GiUG6fKbaMnqLpFSYIB1QT2af/Ng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794465903;
	bh=/kYvCMxk+iKPsp+crhPWOZQehuKb5awab4IH1mh/wnY=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3RaGJaW4aQVfUFg6g6q6u/NKR1/HjGYXFvq7gH6DBkwYRnTYRjeOzf5i6vtoYRBY
	 Fil+Us9Z55ARC9/SKE+ZhOgU+zbJ9wc98lKy1dBsbhlh+8rHeynsJ/GqEErmHUdJcO
	 jWUO9B0IADmVtb5236NRN/1mRTs0XnzllNNB6uWqaK+8tCG+iEIJOdKruKLuNZR5o4
	 yP5zf2Get+9niMbBOpWkZk8JYZ2DoNd0gDLHJbzv5fNvtaz+Ul0gNPCBEzSdh0aw7K
	 qPinumT+s5dTfCu21mOCI+PqNbEPEuoasMCkRfrREJkDhP8D6j16Sze9CCI08S+Ypq
	 2/F6n9zzUHJrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A1AD409AC;
	Thu, 12 Nov 2026 06:45:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E9A31399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2ED73608B7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5J8IaN2f3gAd for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FBA2608AB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c11c2IfS; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cnTJLNlh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FBA2608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:44:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZajZ2135757
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/kYvCMxk+iKPsp+crhPWOZQe
 huKb5awab4IH1mh/wnY=; b=c11c2IfSj4gO4ziVAmjX8rQl3at3pVYVy5aKIv6d
 6HplUDy/rVaELOrLyUuMaHmMLlDcEKi1pNyRYhnnPFz4Q23+iClcGqFET94wvRIW
 zn6wrH5wLhHiZ583WUjU7oNk/trV8TaLShj71EAi9li2z4+a+M7FVsLJe45fdttd
 L2W+kYDdJ+EgbKLEGXdDDqvb2Sr23REB4t22q73V49A+v8SJxi1CHxJGSQ1OCrIL
 6SxVGnD5q06zM0riCyynqAjw+QNEMMzwnjeZQ42MEjVSLrNsmWyjWjrkWit4tvlU
 h/kztTXO49CJT63osoMAB8ldvWgIztv1mR5x9Jzm+5bOWQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjvepn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:44:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f6f4fe531so724896185a.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794465898; x=1795070698;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/kYvCMxk+iKPsp+crhPWOZQehuKb5awab4IH1mh/wnY=;
 b=cnTJLNlhAyMc39+cKdyTrqysjoUm9HYZQ/7Xqa9VIVbjZEZpjKSIs0PEymbsgxbZ87
 nG6lPc6aZIDC1RfPpsSU8CRshfySSJjMKoKkzEpCv0URg1LDFX/3F/bSBwAFi3PRTsqZ
 WHkN4/hMzweQJtt1GnHKER7JOdZ76VByPUODI7m0e4ACnfzg8QfPITB+KMET5QtC0cAa
 JTaYSd5aw0oach7pPazV5MVRcrFgSgCMGDxGbcpu+qSDFnHfFZAsJqM3mu+7xfzUjXC+
 +p9sTyG2/qv6pYkaGomPT0cNLa/Acj7E5mFd5BYARvyA1EaAV++UowSudYvAhquGq8vx
 U6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794465898; x=1795070698;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/kYvCMxk+iKPsp+crhPWOZQehuKb5awab4IH1mh/wnY=;
 b=JfWgYsEz9Y8zh5zidP6k1704wxfoEvp2sAb5sO0Uuh1lltatO6iy4HC2Q8Wj153Mtc
 +0icNBtDplPGRKmxvdHk4J0ZhmW5ywkEygkDYib+UuLoxuWB51vhC6cihDQkFH5Qaicy
 yP//lxX7uR856CZ1oXXm8AFCTB/tjf3iT/pvSOb9v4/bqvtzWNnTW/SF863JOPUCazfJ
 knTRaDvvX5O6VUiMdOzMrv/h2aOWDwKJzwo6z5JN9Sq08tK6EuIG17/9+S+CY+cxytJP
 xY7kQU8jSOWcLssyx1ssOvIfhkb5qkPV8vrCddG82ytSoF/df/3/2i2EbMPKclT3ETtd
 Rryg==
X-Gm-Message-State: APuU4Z9i8xRdmk+TZPYLPXqGq/1AHSsaFLtDTorpJeJBGXv4htofkfl9
 ityn4QXjKQIkCO4DMO80PlBCEGoyoOX2NzrYLysblROY32ST7mUOF/xaRJsqx936fDmjofx6GuC
 y25Ph/0d575oPwO6ZsnFpGgHt1gkeSTWqeM4soxLCFQ5lFmp++7OX8dSGff1DmmkQbUCDTOg=
X-Gm-Gg: AYBFou2f8FLvEyQ3SAsLUOK73wj2G81yAQVjlns3oxuT0KEIO2JF84ovqpK1tMsapE/
 V/IuXJ2Q2gXHdoJpMkf3olEpLFkF7WVsBbpB63jcE0u2HU4VOXfDn/H12paoO5R4RaMm4Iy3Od1
 hV1zX+5DrLyDCQlkXsDlGLZvSyYVnqLAEJEpxbzuQIV2DJgusqfz3/9T1jEaJ3/J3cV46HUjQwg
 BmjXL40kyZfk7w9REbjhjm/W4lTpSIFaexnIAZvhAyuaqmhWNbEUnjMIV/3CL8a4OHZfFgGK+SK
 CGFE93/4AgbJLA+BNmKrdrmPyCiqK/nWgf9RmZ8F9kyjgEPPx/F1zGxh+8ART/RwQpdW1y8zK4G
 ILuTzhmqiAjhejE8wTM9afH9GeGMaUIfB/iiG1YodcNSRpYIUk5c2+ZaFD4E0qCk6VwjYJlG0cK
 JQdA==
X-Received: by 2002:a05:620a:28c8:b0:945:c3b7:e704 with SMTP id
 af79cd13be357-947aff8dcf0mr783382385a.39.1794465898047; 
 Wed, 11 Nov 2026 22:44:58 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:945:c3b7:e704 with SMTP id
 af79cd13be357-947aff8dcf0mr783379985a.39.1794465897621; 
 Wed, 11 Nov 2026 22:44:57 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835d2bf91sm15245292f8f.23.2026.11.11.22.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 22:44:56 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 12 Nov 2026 07:44:55 +0100
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 2/7] ufs: rpmb: stop the model string at its NUL terminator
Message-ID: <avVgZyWj1qwekTVJ@trex>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-2-701a62dfa034@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-2-701a62dfa034@baylibre.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfXwwxkWnF9GWY3
 n8hX3oDyhXIiXaV9bxjDXPEoHlk2p7URyz5D8Ms/P94Mcy5eRxttwemvGKnfJmTOA/jvy4pytuj
 Ccr3QW0kWOc6zc9BmjygNd5ZcubH2jv3sJelW4n4pvEEXeuCUKM6tawoBSlBwkX86HvDI7HRolJ
 8YLXnzqxpiGo27RnAXBnpEJw0yNXjpv0PUeM1RWlDsZEvB1rQOsbxHDsNFWKyXT2NPW4tWEGO1i
 Cl1wQv3LEeYJewLmcEGU97z7cpYilgY68VJL/zh5ZrvuegvdleFe1SL03dAXS4iSKZCO144VCIx
 ylIdKOBLEnmx7FNZItbEFWAQTQOxUx/iV6jfi0mT4ykj0hphDyqcqzAmZnXwRzirm1bitHASZPm
 d1vNp8sdcNWyaZ90ZoEaGSetNPgGHeikOP/qx5F9VjDcdQy0WpW8HyexonipoLloDgFa1E0+wqt
 YL4145xYyT9I6wJTm1g==
X-Proofpoint-ORIG-GUID: MUGAk7PunjJXd04-6-iXoKuq03zPf-Ka
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af5606a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=IpJZQVW2AAAA:8 a=2ijmqyaNR7VxC7y2N1AA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: MUGAk7PunjJXd04-6-iXoKuq03zPf-Ka
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfX826FLhmInqGr
 IS+4619RUsBGBT1HvAepTzCnVIQiVPa+cozC0pZ/R/Nn3we7fLcFTxMCyJA+GS9x7cYVwP+/LY8
 4dddbyyzf9wLjYNDAXNw2z6y6yORVy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120026
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 11:21:35, Carlo Caione wrote:
> Some UFS model descriptors contain trailing UTF-16 NULs. Converting them
> to spaces changes the RPMB identity, whereas Linux stops at the first
> NUL. OP-TEE then derives different keys for the same region in the two
> boot stages. Stop at the terminator to preserve a common identity.
> 
> Fixes: 87094d8062bd ("ufs: derive the per-region RPMB CID and size for OP-TEE")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  drivers/ufs/ufs-rpmb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index 508eb74d976..8b61760f071 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
>  	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
>  		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
>  
> +		if (!c)
> +			break;
>  		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
>  	}
>  	out[n] = '\0';


have you tested this with Linux - RMPB access from u-boot and linux to confirm?
AFAIR (plus the tests that I run) the code should match.

> 
> -- 
> 2.56.0
> 

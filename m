Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C8606A685
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tKxqk4yp;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KiFVwUld;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OUPQ2Gi0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CA0780E5B;
	Tue, 24 Nov 2026 16:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbNSl01e5tFs; Tue, 24 Nov 2026 16:47:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 924EA80F66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538868;
	b=pCb2YTPs9HmidT2htN18U0fQiagsDI/uLe7WYviZAPqpKdznBEyMGb7jBJkPuw41skCl
	 veDh9Tm9zP8Z1z/lIobt7GIGFxwncT4wtu7U5F+0eTbbfjNODhpb5EmyYjMoj8YhmlQ8m
	 Uk3b/GzG3xoAsjt1AIFLuX4nVmX1kZkysGvFed5JtPc7eliN866Bv0zwQLYbwWckVO+dl
	 3gA8M25d5OQ7y0wYatTrDq2s1KlefPXL3+7AXKWefMlH+W8llVdrXefHFWhSjsRmxmeGW
	 9ExmTvjAZnYU1VvTUEAf0w7epVIP2mkY2hie/bQcv7a4LZi3++qekiWoo4HKq6XKOKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
	b=UkmuSBGmDVfQPPwsq1BfI/DwRgh3r169vDPsHPovpl0KsfiVDZqsE0q6wwdL369WzoJC
	 +EKv2goFD8nAvUuhrqO58Md5kLOyE17lbMMx57fFNrryafQEodI3ITpOpIrx+sNQJceYh
	 7G10KnFVllWzloHKdF083x3VvUN5puki/ID21J/ik2+ZEI1Jz0FnQZTg8pLdjHx6xvxpP
	 u7aZb39/EOPKi86/AceOeZIH4qInJ5OAnjA1C/GFVnbdZeVrhOeph4dAdYYNC4LFSCojF
	 kLppo7/Ap1di+RDZHl7ZmUsV400yRfjB36QjvHEauTjwfiMsUGwHCu2UEQlEb/N+FTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538868;
	bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKxqk4ypOPxwsK0LiWm2fKxBcdNASR5sCcoKEOI87B4LtglcN73QLyj+5ZFgxB3uH
	 NnO/HppySi0y/5gPAzHg7uIy6RgTm4S/puU7OSf4QWlwWd82HStHJZ7Pd+1fDrW2wx
	 dJE3vmF+QRFIFnH74ouLhDjs7WxPhoGkBXxX89ygF40dmsJHrtCtT4xtdFDfoKlxFO
	 hPtT7CRMhmZ8/YIkOzVDVSOun7WMprqEFhGxrj+WrZYRhkI1Rs1RtAuvyNpF2K4pnB
	 cRleylxWLyiy2/ih2iUwoxkAZKPXpS0oDvuB8tnWEoi+A7NwNnFKxfCGoTLrNUF1hx
	 stUujqbQ65uqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 924EA80F66;
	Tue, 24 Nov 2026 16:47:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D28F9715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B85F94059A
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AYLLXZjzhqW for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23265405C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KiFVwUld; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OUPQ2Gi0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23265405C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:46 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFKxen4123963
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bYRQxre5Cy0
 l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=; b=KiFVwUldyBOoMdOwUmzM5+ezcth
 DjQ5dB16uqq5eiy0WDDY7ChTCxJBsXcqtcYIN23nPi+UWSzYFcUrfrt6OzHUcUit
 eTBJ6P5yCp83vh4ymLjn0MQQn7rw/fC+evsbgJr+RhSjZGVsRp6FllQh+LuKeARF
 LZULLtwLXsvi2wKSoAK4e41PD1f4IQuhy4ufa8aDMPw6UUfkrhHrMN8Yp41SRajh
 lMpz2Ly4sDyNmjcWkjdHoF7s4FICZjWymy24Wmbf+0S+XLdhDFGrROIxQHx9bclh
 rKpJTh1TQBR44dqiwgaxlTcmXi4HBuQfReDqbRX7a7Po2K1qlzuRi+JFWdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhau2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-386a0f79047so4820647eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538865; x=1796143665;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
 b=OUPQ2Gi0KslbW2wopyc4wubAtl35FDgkqAy4sNjvZQaMEskg2RWKsTjd9vKfXthVMs
 oSNOpq6mLO89O6h7WFHY7NJ+QPuW2tHhn7XMPbaee2OUPnEQnA74MsBAWuXC9MIahNHB
 C+bXSG57O+PWOH8ao/pViX+0Kxs1E5L5U1ntLl7GB2MnBc1Do3TzlxEDEjkqh7P1OgbT
 oiLuUHWqz+ltyY1RUKPt29I0HVleBqrCLUDAFIy2kVvkzutMNg9Trom6n3llcfBCndaf
 d7c3+r2ldjIl2JnUlETjRF99dBUsHxOOnLDPfal7esgB5kUUnBtoac144/toRLEhgpRM
 WwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538865; x=1796143665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
 b=BSLHmm+yqFqZgC737wwAoLakqIAo086w4Xf052rmdoHau/LdSJbfXBQeM0ldjnaQc3
 yIbCbs9CXhT2KqjXcOC7amDjPXPowXctQcwHeO6ZejPOQkkLZ9tATj5Bul6XNUoim1HM
 CghB/nN3b7cTmNN1rT/nwF1L+ALEg9ll7mGx35G5KNJ+oVaqwHUm2YgJ65UX9QDZtvPv
 5WGCZtCrYEUueq1dDlM8jmhkRB5llldFzwA8Be5XKAKe6nS2PY4I1+KxQK6BVq6QWBF7
 X5qMXu+bn5EQLJzPHIBEza4EnypHYs7xC3IJBFJzDujOUrhdkj+JsFWnB8ZwqjLRkfOQ
 tPFA==
X-Forwarded-Encrypted: i=1;
 AL+hErH1rRaKBtNNbUSQCM+Mt1FPAEZNkPNlgbExGA64lSbX1bdgmByJhck96zPLpx42XYj4w/xdjc0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z82WHHjDD7AteMhslqLVWymVGPiMX4FTuzLhv1Bvxg2u7lCpuMR
 sdipaVdjtiJCOis6ssNQeGGAsbplEe5/hi2dXqUHaIL9h1E/lkD/j0/GB2h4Kt/yfKx5W4HaG73
 mTA1UdMvMg/qEoI6YdlUdwTy4VmkP5EHRoDV7aLue79JgHrti5xQ/sc4doV1i89DbyUAazN8=
X-Gm-Gg: AZFdTZdYTQ4bNmid6vEMuznp7Hzc+WXs5n1Jf9b3w7AZ8D2N4ZrlLIGVGdykl8MCqIY
 evA2BFE94o7sWWWHG+RM8lrv5RR1dlOnJVAcQTJ3c7ayZ5NQCVdeMXPFK3ahQ5PBpXF91KP5gZo
 8ZK1QWq4E/5pmiCHjSWaHdTt3Fo/dz2HII2w2k3M8C1dnQR9uc/QsmH/CORTZMTrC+TdRpWtadf
 nbpuc0oOEQWB19PKNAffGh+sT0nN7mmJLhp+UZxQ3ugf9hBMoUoHmrwzUv15mbSa1IT2Qub2jKG
 pL6twpalDE13ZtR9Oh4ksaYU3ZxT5cBImT3fQ2xDCfd9EYa3Wa/rojqRmj0luT08VWWu09cVOXU
 DCztECa6F1EI7Yq8bhyNeHQorooByftfY68FTcLJ29Xw6PbjP8Z1YuwghU4OwDG8uHalVkFR7Ab
 pSY5lDhh34d7mknasYV9pCBJQzrSq7c5Ma0xY2Xxd7FFeM8vy1cH0b9Gd3ewF35lOToXzg
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id
 5a478bee46e88-38571807cecmr14602784eec.37.1795538864729; 
 Tue, 24 Nov 2026 08:47:44 -0800 (PST)
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id
 5a478bee46e88-38571807cecmr14602746eec.37.1795538863868; 
 Tue, 24 Nov 2026 08:47:43 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:43 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 6/9] tools: qcom: mkmbn: add Shikra board mappings
Date: Tue, 24 Nov 2026 22:16:57 +0530
Message-Id: <20261124164700.1606518-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b05bfb1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1LA7DHwFGBrveulqWMoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX0VWyJgxZyh17
 LQyGZnaqDhXnJIkg8sRVXgMTnwtbLruydRCqyWqAKBMd26KWtU10WqfYkn1pt9+3MitetZVB8I4
 kE6anIV82rW3R2AZx2U8ASnxKeYXElE=
X-Proofpoint-GUID: gHxbdglFW82BB2HKMS9BHt6Q_HyK62pG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX0sYt3E3rPQy8
 yhvoZEUKEqfbUXhwQFIQocbrO5yPMFDnbAZpnB3jq/uPl3ONzyVnjqUm8WRK0HgpLP9uF/+mfdT
 /ueL5FPTlTb3QFZWOQZcaRAW/ywYYVE+uL3b6zoCy04DfggqajCq2EoB5eRejViGA0avX80LHd0
 noXecNa+WV4IqvqprF7b9W2MMR8Sjfh5/Mxum/yzCNhEjxXBv6Uafp87ekw5J1vCW8PpeppknTv
 q8IpegJD32NX65CIem0QO7DBFZsL0q1T8Hmr61JhpfoaG3kqLNIG1KrtMN2Q0zAFn0dGghXBt5v
 7ErIUOAAYhWUau41kWyOqLNgJFjct2T21qEZ0cXtktE7WcukB6obL7bds75s5xdI3W5fOPuNvLJ
 KJqQvfvuuy99rNXmzUFTa9CCYihYti8Fw9GoO+aVuvpMRby4doOHPY6Hk19LDmg8kjlYVhPWp8O
 toCNTk60DkIi4e4svkw==
X-Proofpoint-ORIG-GUID: gHxbdglFW82BB2HKMS9BHt6Q_HyK62pG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

Add mkmbn entries for the Shikra platform using both the board-specific
compatible string ("qcom,shikra-iqs-evk") and the generic platform
compatible string ("qcom,shikra").

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..704011ed27a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -76,6 +76,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
     b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
     b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,shikra-iqs-evk\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
     b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
@@ -87,6 +88,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
     b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,shikra\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-- 
2.34.1


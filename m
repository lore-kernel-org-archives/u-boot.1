Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53F606A332
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l99TkIfa;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RK20ivhl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TlgMVJIX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5956780EE8;
	Wed, 21 Oct 2026 16:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iafEXz9lZH6H; Wed, 21 Oct 2026 16:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA9B1811AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599060;
	b=iYjLmUn+2pAFx/DJCzz0YpxDWcXD7SBlysfOfqV0vhpaa3S4VAyyUmzxKy6sHAZr1DPD
	 5u6RnHKAB1Flozq7XKnQZaHvdjrDqL/Ezw6s+JRcNl/K9BeXfG7JxqOhNIrObn89DIMi/
	 lLonAjgQIFkOjEYO9CgnjzVvEFl+TOsSKcn0L9ydlzXdYwlS/nahsGJmdeoH0iHSk5Vjc
	 C77QX0K+8oUYL+kY4XEU4hojTei+uA627PIEyXYpJSm0f7+ztbxTQwiPYUrH/It87ePie
	 hp9yFNXsvP+oPfTc8FgyZB3VSUTOinmlQnOi7YScr4MGkaYs0N6rtevrAjde9iqvilg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SESogQuZH3UVzI37JjvBHK0IaPEPXObTamKX+rQF5h0=;
	b=sY+dGYQIf8B5FnB0EC0NtzAjjB2BVRQKUF2Tdf3uzetJHIbxBEvdE0oaCi4soIWLSamR
	 KwPOixD7ak6wDJMG6BJOGChngFHM34OA+hvk8xfDMas5RPZ8gkziZ4WY/7xI3wTUVW/2n
	 m5dqOyCQLTai2xOwNr8tTumtFPUkEEiG0V25LuoaJPGvYEmXhwBbyDBxgV/xmxEIVmOPO
	 vtntii6vXv3+8atx6CmQojndmFnEqb4xYU2FM5MB6Ae/Kmtvb5RZHFga9WvY8vfmWErgj
	 Y7DwRQmeVGuLoOq0EoJ1UBdk9MnNqd/z9/LpZy1/Tfvk4VaD+EVorhlYqf2J5JU5UcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RK20ivhl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TlgMVJIX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599059;
	bh=SESogQuZH3UVzI37JjvBHK0IaPEPXObTamKX+rQF5h0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l99TkIfaTGMagVxE4cggGASmnAnuk7lT59zYlBCUCoH0y19Ss8ja/tVxQ8qQ7KIR1
	 vDHkOV9Rz7A4DfgmJmUGSILZyzpXHGH/mYCtymBTkcaEp0VMfG4/JuQ+HMB+Pqaotm
	 UBmXnWV/NRoRxWN1p17k0bKn/yfKnnd3fuKzRWZh1kpuXs8C+OIYV0fC2rUqYzXNSa
	 zxlt8IlP40mgamLsWIe4wwKW+NsV1tpeX2+msL818SPES6N3mKyACFEOY8abLpqUBM
	 jtDZeqBb2iAnlUz7J5nUqVQcy+gnITkfj4I3u0BkSlUYnQnRvrYR3BWcWrO1caskHT
	 Pja25+XJ8rEkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA9B1811AB;
	Wed, 21 Oct 2026 16:10:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F361E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3AE0811AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBKAp0xqPOHu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DF7580F88
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599057;
 b=mJtiP9R55dQprl2/YFIvoPlC7KXcZOJG7h3kcdaoWNjdjaxgs7VUU0mTpvf7QnSqjQHQ
 hJyVK+ZjmEMPYvc5yfN1cpglo2SNcpi2TwLLYdEDlATxoU83lIxmFjfKF4RIhHjprllpM
 S+nix9Z1iXzEKOd0ryaE/pfwWbLoAfkw1tk9GGzVObdpZQbB/xR6R/258eq3UIV8yP1lh
 LN0EgQmeZoDmibeJjwr+UP+TOLGYUOHKOH8JoelZTCWYTPovPI0ghgsZOTkqJmzazE2Wj
 dbDaERVinzy0YFvTGVZ9Qubt07zMaEtfzX932Pjxzqf/U8FSvXlocJAXhHHF//QMT8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599057;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=SESogQuZH3UVzI37JjvBHK0IaPEPXObTamKX+rQF5h0=;
 b=FE9ZTU4RzE5jI7PTLL45NuzF80lUrb27xQPvQLTK8BpnuWJyX7fPfEVK9hWbOjU1ePgk
 IvpqPmgvJyKgkUH0lQ1NqK43q4UOG1lRO5A4ouIZyxp33Ev/+/To+/EdWHUV3ExwaEko3
 rGUEsrk7pgR6uPJZmtHOwd/NDkH+Nu6sfbam0Qg9rmVhStwQsQhVBK/VJs5tt7p78g/8e
 itdKnE2s6u2hZESo7W9riD1opbvOG++gnOOO7TazuHoAx+gWo4XAHzb4HrZFladwONwLY
 BhY9/FaHlgND+UFATmMaVbrXFG9JxB0CORNE+z0WEyYjZwn5ua0bC/IrDDK3y+Y6gNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RK20ivhl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TlgMVJIX; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RK20ivhl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TlgMVJIX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DF7580F88
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU84k682552
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SESogQuZH3U
 VzI37JjvBHK0IaPEPXObTamKX+rQF5h0=; b=RK20ivhlN6lswYRaxcgtLvFTsB2
 3F0b+9B+jfXHyVIqJN9WmxfxNxSu7mFUyGetVKPX/ykwX3qVrR8r6V/djeeA5m2A
 Nvi5UdGIT+oTvSv+IXOB/5W7kS7qTtzQlplfJTJZY4W/fhlPn/r1eswGAL92x5hw
 zVoELXBteyLyrHCkriucjsbD3MlzXxFeZ82wh5X3MYhkLZOZPLPToYm+y59B/S6J
 2NIhIOayPEkiPwXLuqvaRzMWVDR2NdMAXMzRiUe3/GlqO0RaePctD8sfuRZnjrGe
 Kke9MqLxZoe9AZs8M+BTBeXt4h53Pi/Gtm9Q/nZ5ybdxz+wnIZf7L1y+TEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrrxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so3565550eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599052; x=1793203852;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SESogQuZH3UVzI37JjvBHK0IaPEPXObTamKX+rQF5h0=;
 b=TlgMVJIXbSlCl1MCCwYGoUi2hRwh3s/OshFx3t7KZaekn85Cy76g7zIN2AEPKH4Sio
 2DX5N04z7A9XLMnhBmqyb3wknR5cuD6irEXbB6asO9pHYiPsLbb86U2v2+FA3ig7GoRD
 3HSiI36rn/NP7DRCMS7TSAjkdtJGWWRZK7JAP/EdTWGRZpGfDlMzyTSjhsPW5tXr07go
 GY/wS3TV5iy3+BRyh9Uew6CdNUd0SH8cfmlL84lBcwWyAp3jz+/NUFbF65/RzN0JIs+J
 DT70HSLC2jxVH5EHMXTICA3WYmuxZ18HI5zusVGr28scw+Ll7VlYWpB5HevwrdSreXHl
 RC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599052; x=1793203852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SESogQuZH3UVzI37JjvBHK0IaPEPXObTamKX+rQF5h0=;
 b=GuiloluGedI11KFE3U/RE9gPBKKsOjVvOh7ZAVMnekLamk9M0eYd7d+yGlNqWhj/A3
 Yl7yQT0/h7sv5qrgC9Koaq692dxdymZnLyGoOkaSQvzM3AEayNUmJya9GNUrlovy557/
 +G9jbZDOV5PrIWahMrrN7LY+mZ6wOTLOSU1hYxE8Ctdm1owmpGA12N1fWyeIbBFJU0Xz
 CrABE76oI2B7lx0ugAdmfmRaE+FDI7WTQGaRzMszNsPONBtGcYjYaPNHqZcSB7I82HZk
 KKGBYvXDA8StN94XQYaWJzFdG7fFUmZcgH7u7+wzd8RqRzL5FPqpmaLSjGIKaPK3SsIZ
 kUGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfNbggjnPUDNlY/MuP/B96xd0w/NzEPbcQv2oE6lZxiJL1nwuZ8+m9D2p8FfUeSTQXqI79mNA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJTdr0VZlKl8zLYRc56u/us5ou/7T5PtCa0m7CUFdcnBxqerNMl
 E4oNaj6/Zrcv5Z05peyfQ/gw0qNI4cImaO/b9Nq/uoLmPVG3LtlzUZBQhGjI4WNuYkdGVY0KOI0
 UZ8KiHgTkjvwcnqWGWJuFyE+cQt4s3niUzSNMrURWg/DwwQoO216jl00sdQp46BEEvF4zaM4=
X-Gm-Gg: AYBFou1gxPr8mVQYJRRiC4Y463hJrZGbJvbb2GPAWdRRAEraOC7P+zUZKcUJK+SbDZH
 Qs7//GBCyILprYIsE2rYByP/Pq1SAWgXe2wBYGKXkgAugBzMr0Mxb2SD9UxtPkDwbGOBDINpRzz
 6QrjsoUPm3R7R+nxRPTDkN98qF+dJh8RGH7GyW5jFmy7mRhJRi8j9gLrrKxlj/jlQ8i/rmeD9Wb
 eXDPyHt+p11tjmt42GpVs3nD/muiWxE5GI3OxOY4fyXZMcj0THYdmO0as/fRj9Wa6P+5kpyWaQC
 v7/waDM/RiBlhvEZNNWMhY7D0OmX2KOBVRNB9LslBcms+1iwUZ0+cy4BGfiCYgNVKVgg19OJr0f
 O2FeotGjgmDSUOMKfk23poxBx1Ibm9KYesjAxnub6X56Rwd+E6UHEHUfgsZIAfZ4DZSkpnor2Pi
 pYMr5s0banuDE9zM3qfBc=
X-Received: by 2002:a05:7300:d112:b0:359:861:7cbd with SMTP id
 5a478bee46e88-3674c93a449mr3290160eec.10.1792599052407; 
 Wed, 21 Oct 2026 09:10:52 -0700 (PDT)
X-Received: by 2002:a05:7300:d112:b0:359:861:7cbd with SMTP id
 5a478bee46e88-3674c93a449mr3290112eec.10.1792599051668; 
 Wed, 21 Oct 2026 09:10:51 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 12/12] doc: board: qualcomm: document Shikra IQS (IQ2)
Date: Wed, 21 Oct 2026 21:39:16 +0530
Message-Id: <20261021160916.3894471-13-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: deMSL1HeLhNGM9uupsvP3SGQwrAZ1GG7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4cbBBgSfyE8W
 9S9eAAA5pL2jq4SVOddZkQz40AL4TWl5C+J/I0JI9vYF0WVyarZgCfZBtimWU69vYKu4C49HwAk
 rbdY2NwhRaS8VHitQ+WK2CrCBS6L+CQ=
X-Proofpoint-GUID: deMSL1HeLhNGM9uupsvP3SGQwrAZ1GG7
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e40e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=PKClzCG2gZYjde_UNCoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX5UxYUzljJVyt
 lKioqAxNkFnlMsUUQGP07tepwX/7ADG9S5sgWpUtrVhlJt2HwxZ3AYh1bbKhdm0CaZTA2wXTTzL
 kOzXPyu6UFWYQBEr5eANwuCsa+xBOd+P3QnJQoHLd5/ZOn+/bvIeCI9vmJPklkkQXMhm58fD/ik
 MRNUL1Xf4CDjzclznoe/9J02YpeAesA3nJbjEOgG1ISEV/ERj012bZw9tjENrhzik47kvAL//Q3
 ZSDADOUNkeeGv48W4atRj2iQQqsGvjMVQX4YZ4DzBLHblw8oj8iscjKCK1mZN1mxoGRmGjPWIqM
 wGjlP+3T2fauYzE42LflT1SxP9ExdPZHjUo3K6eflhFlEUPBmbiaJ6hqWRqSNPjJWXZu8yoxi+a
 sgCLbGkr0t1cAon+TqtqWaulukoC4BGbPKS/lRiFbYe1I/NXPS8Z6a92oweIUvyKYB3BYquxTBu
 Mpzgr62KXTtIgktELBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Introduce documentation for the Qualcomm Dragonwing IQ2 Shikra IQS
platform in dragonwing.rst. Add Shikra IQS to the list of supported
Dragonwing SoC series

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 doc/board/qualcomm/dragonwing.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 3024c50cdc5..1f7a5588b01 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -5,13 +5,14 @@ Qualcomm DragonWing
 ========================================
 
 Qualcomm DragonWing are industrial-grade boards that provides various series of processors
-such as IQ6 (QCS615), IQ8 (QCS8300), IQ9 (QCS9100) and Q8 (QCS8550). These SoCs are used
-for factory/industry based applications. Note that the QCS8550 is a derivative of the
+such as IQ2 (Shikra IQS), IQ6 (QCS615), IQ8 (QCS8300), IQ9 (QCS9100) and Q8 (QCS8550). These SoCs
+are used for factory/industry based applications. Note that the QCS8550 is a derivative of the
 SM8550 with the RF modem removed, so the SM8550 defconfig works for both the SM8550 and
 the QCS8550.
-More information can be found on the `Qualcomm's IQ6 product page`_,
+More information can be found on the `Qualcomm's IQ2 product page`_, `Qualcomm's IQ6 product page`_,
 `Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
 
+.. _Qualcomm's IQ2 product page: https://www.qualcomm.com/internet-of-things/products/iq2-series/iq-2390
 .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
 .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
 .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
@@ -19,7 +20,7 @@ More information can be found on the `Qualcomm's IQ6 product page`_,
 
 Installation
 ------------
-First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300``, ``QCS9100`` or ``SM8550``::
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``Shikra IQS``, ``QCS615``, ``QCS8300``, ``QCS9100`` or ``SM8550``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_qcs8300_defconfig
-- 
2.34.1


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FE606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lgo+9Lzo;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VMJ6uUju;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GzrN47Hi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4FAB605F7;
	Fri,  6 Nov 2026 06:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hE6E3u85i6b; Fri,  6 Nov 2026 06:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B91460608
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945558;
	b=bGGQj2tSYR9nuo4fqtCb2mHqjfzpDaezUFwh7oiTXas54Z8U4S2A1MXiPgg5+XLf3Yec
	 zYNTGO/n36GoaauW0zstz+397flUFrdjdmSludbQRS6X+wYCJrEtv+2dSTtNQZjNJfLgk
	 c56gP95OBHYZ+7TIKqVyUEGvJkblb2XOiVREvfw0RhLrmY9sD9awHEYXNTaLDIQXauUtr
	 3rkYs4bqSvIan7ly+Ki5aNpgTGi0GIlSYnnsHUrDOW/16XQTadPalQhQezW/e6xGoB3Gw
	 JPfp8oBG5KQlbcTsVFYw5KeX9KfCZKsuFf/4MMlBRG4ZFA6vBY0854gzo+yM4DpjEYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ajvwVZRIcH8KWdTQdB8bPP160nhqHAZcbbiccXt7Xoc=;
	b=OSQyUs09tJJvqFptd9zPbiFdNEDOVwIFXlTGfYpxxScFRXynAuuRqqld0rtkRnw3KTyV
	 xjSPoyVxWB3NC07qNRoS2sTiFkNEFfYscXDseDkTrAPXrqCZlFVGIKmtmwxsn2/RyGbmq
	 3MdvgIMS+AYd+gA9Y1MDmHZuJBEAMkYYZfGKh+ONjcBtOzEnfb6Z6tqRMY+j9Ny6wJJ+9
	 K8YyDAogSxss+leIrU3croOY4hWRcmRtcLPLEacdMEfc3X/A376qgeFuCmpMaPsTuyNW2
	 NKoEjvXEXZgVrdMKNLvPMz8HxVTl5I0qQFyZF2vqEZ9A/41ahe/EChlbI7kBFXri0Cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945558;
	bh=ajvwVZRIcH8KWdTQdB8bPP160nhqHAZcbbiccXt7Xoc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lgo+9Lzohh0oh94XrRJVO+e4KteRIlac6P20e/5kBTO2MyyDZb8lVV22mv4C4soEF
	 uPblTf9LuPaMX4v2gWvp3ZQMgiA8ZqSdp1SnJ3BhqQUMmAJzbCVDbeoYAswR+GIO39
	 ckTV+OTg9xMNI0wNMLTypF+//eRNszoCvTSf6cz83k1/Jbs2JWxWMkdLhrWdfZcRZN
	 h9dFF9Xje6vmUyJLO5Cta0PlJ18kOFzbmgRsmME22M1knVp0Ehn/4f39/fsTIyAo06
	 7xONrmOVD77D2gclSdAULbAN1yg+8DjVK2GXDWAwNOOa6lKvwn3TIQA4VTJ18SzcJg
	 160j/YbNIRXYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B91460608;
	Fri,  6 Nov 2026 06:12:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EDF932A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1079181083
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0u9jZuBY-VR for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F02AA81082
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VMJ6uUju; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GzrN47Hi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F02AA81082
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A64072j3856996
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ajvwVZRIcH8
 KWdTQdB8bPP160nhqHAZcbbiccXt7Xoc=; b=VMJ6uUjuQrC7MuPokK7Kmdyj24X
 FXhetKC/NUus7wsTziECeX6agltUqogcm8ff6qAkxa09XsxSkTdRoDZmm+kIESkO
 4ejeoIuFRP06roHqwYw+Nxw+rTmo/8ikQb4VYHSb3bzGXScLCVluNtHdxMdRe/ak
 HWw+s/3gB+CwPHCqs6lnqVZ1cahCL51v3JpwpbyfXXXB3T4z1vdwqBKjWxX67CBN
 Pj+BpTqZwDDcF4RP5ivFvfeYNKjpic3D3gNq8RLtWW8++EAAQbFHIeodGA1pEj93
 kbDXRygz8HvoeEy1BYQxJyhq8UnpZUgeLsDDtYbPqxZ+6TNjjw8pnSEoz7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9s86s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:12:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f479b9819so588179eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945553; x=1794550353;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ajvwVZRIcH8KWdTQdB8bPP160nhqHAZcbbiccXt7Xoc=;
 b=GzrN47Hif9O7bVUsYDZqF6sU0VXx7bUwt9HyCZpv7OfFCxp1RODoYO1VzAvKRGhOzv
 1FpVqVNwm/7ol9vk94i4Vd4Lyyddnzn1R474/wST0F6LCLOQiP5Fc+ALgIyeHw4DVrnN
 WDoCE1xz14MMkPXOnY95GJdQvnt0YP5XzPfUaD9q8HltvLzn3sf5FMld1/XNFIsDtD3s
 Ga2NFVe7+Oxl/EajxFsLu+w+cahuPgzoTGIu2JqVd+FJPwhl8eox1rKeupvA4yHx0Tfc
 tYO8XvyHuRfeTlt4gtnPe1UvTax4UXnA8PHObFzctBiZs46OPGZLZMCO4p11ZHr6zLtW
 JyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945553; x=1794550353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ajvwVZRIcH8KWdTQdB8bPP160nhqHAZcbbiccXt7Xoc=;
 b=yBng55M1zeLg0kD15NI8HPvSJv3wWs2qwNLpfxGrGOfe8GZ/SGzcYhlocl64mIc34M
 ouaylr00LuLYqlOA8asiGxVEiU9iQJGrHEYGOeavtUJzXh4+F+W53EVdi0FhBK1tN6/B
 kMTY44FWRapMcCTED8JgwRgQFMsHbZvFjz8B+7yFGg1281MazCYdmG50w/hCveBWx7vF
 EbwkyhoH9zU9jfUxUsGpVh29xqwBFVtpynVpPLT6ZEe9dJD9uZRaq1QLiX/eb6xiwYVO
 t9YTrp3flRwevMw3C2BavcMBcst65h9cPtffMtHcBdej5pO/W/2+sOjeFIHXpm2k5Xhn
 kOVg==
X-Forwarded-Encrypted: i=1;
 AL+hErHhVmR+fCZ+pYT+5HfIk2LKbskgieT9xRsZBofG9SoUAuw2sCDkEI8wjDn/mC+8UeMXE8R5zBY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1HvLU9DzkuQn9ec07EDqNzPMMpBHjiDGH+9Uv1igu+vZj68dO
 i/qH1zI4bEUIepQ9b2RDTktQK7CMRfiXzyPMKWrTnqQS1yRjsZ8RWbWqK0mNqBrprrirPEpNcNr
 Y+EJdEBn+DTToBqTNCnQ61al8wb+F7ZriA5n52LVG7ar2i6Lda5JDDunGW+0rYdxJkJ0Aayk=
X-Gm-Gg: AYBFou1AZzZ9T+WANgjxSO6rrif7b1/U71ME31tPyKkjK2lUilVKB3AV029SnOuUwj0
 OUx5tQA4wOHfyeOgwe6wDHXngNz5Pr+AKvYMSIir1qi0zKtAPVnd429xX6X+HQok23p85bi8y7w
 oFvYodo0gi+NXhHOwtzidM4Pd0A97YzmkslMYq0UKBLxjzHm13Oy3CLzqhVWUZmGx+Mr8jZ2Pwc
 71RKdk0fbsEL8SrBfmd7t8xIgfWt8/+mJIptgYeHFONLOBC5wgK3U4Z0lxEolT+8IZNPaHwa6MY
 FQfiho2xZJuaZvP6QIw3rURgggqM6XinOoKBSqHOi58PPwV4YtaZU3QSiugNEbpHCWpm0fPWsgI
 c552+BPWLSfLOt+rvXzFf/WPeqvr7+AUysrFd5T11FWUdGEMyFxHSTIQRdL2R/x75jFcu0JuVxf
 Nw6E5et8ulXni0bER7RshK29NB1fYvL/XTweqnAnhBNiYpP2gpYWM845Fak/93AzhHVS4=
X-Received: by 2002:a05:7301:1409:b0:36c:f88b:caae with SMTP id
 5a478bee46e88-36f7612424bmr2026820eec.22.1793945553037; 
 Thu, 05 Nov 2026 22:12:33 -0800 (PST)
X-Received: by 2002:a05:7301:1409:b0:36c:f88b:caae with SMTP id
 5a478bee46e88-36f7612424bmr2026775eec.22.1793945552365; 
 Thu, 05 Nov 2026 22:12:32 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa5afffasm3608039eec.25.2026.11.05.22.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:12:31 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, jbx6244@gmail.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, naveen.osdev@gmail.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v2 1/2] mach-snapdragon: Kconfig: imply SKIP_EARLY_DM for
 ARCH_SNAPDRAGON
Date: Fri,  6 Nov 2026 11:42:01 +0530
Message-Id: <20261106061202.3049194-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
References: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX54MDoDMltLPy
 BlMePPAN7NEu/z6t4pGO/ck+Y/78g+/GN8EmbEye1xrTBLpMwnf5HmkaqxL+xQPI4eI3+4YRG4w
 69U3bZhg7qE8yS4aAyghqVz4YYLlQiY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX4TSNw/0MD10L
 nChopxpKiJ2fjRTxZLmGf6QnlkAYpRlJpNLKrL0mKR3muqtsab/MA9XK6VJFd36LgdIxCKX5cuV
 fHI2tBrCKGX8gHWPuCKsAyIzjy/t9nshIe4kmzL5WjD3vQWWtbuiqUSV0yvV2uZ1jVBv45NItjr
 4at0m7t/h057dG1vHPWNKMSwx5ptT32hYGkqUGhXBPJnmaCfULhbjrnEwbFeiaE7xNymqr8XZZo
 tz9w+V3tuB5pYXnr4VFDSLTEFa+UB9i/ves2AAEGIzUliIa86MZWlGL768Hha9NJBzwrOSNwdBK
 ykdT4KzObQ+vV2v25NQx+ZhOQlcSzTjIReRMn+4jdIxXJLzAXCZmclZCDGvffIS2NnAUF9j7/5a
 QLkR+RzaswV/dJ4pUKERZt1W6xpplgF9Be5hnv/xnq38VFzVTPzBwSGnIWYa63t/+k+sjJGdBrh
 sBGBScMf6If4TndqCsw==
X-Proofpoint-ORIG-GUID: mEDEelhnj065_lDT_QUp-xAY8rGq7gp0
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aed6fd1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=4-tNiDYmfHCmaRq2vf4A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mEDEelhnj065_lDT_QUp-xAY8rGq7gp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
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

Imply CONFIG_SKIP_EARLY_DM for ARCH_SNAPDRAGON to skip device model
initialization during the pre-relocation phase, improving boot time
by around 50% by deferring device probing until after relocation.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..e9068d0d589 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1156,6 +1156,7 @@ config ARCH_SNAPDRAGON
 	select SUPPORT_SPL
 
 	select OF_LIVE
+	imply SKIP_EARLY_DM
 	select SPL_OF_LIVE if SPL
 	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
 	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
-- 
2.34.1


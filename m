Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2A606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SqBOYRvd;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+4dWsY3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PbTL8+Zw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2130405CF;
	Wed,  4 Nov 2026 16:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GUdeem0W53s; Wed,  4 Nov 2026 16:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 397A340684
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793809599;
	b=CccPAyWJgL5st944/bTu2xlaba7p++8rCLq6gTm9/7qfMnwDtd2XfOKsEneEkdriWSdG
	 Vnk1EqDiSDlyj1/wOYYpSwe5nHBUFNMntC+iFr8bDQqosZ9wVQ9yEqpjSNhrIzrbGeQP3
	 CevQ4Mv4jPOtZS8U/NC+w7Os+CpLR3aGa2Zyq8TTJVcpjEd5jgEs6cYbx+WYq8pVAwypL
	 xQQTfHJm3ILjKACH1V+rBHOvPe1pj6g27jYfpoqVnobzAxBZjpxW7Njnz7whHKmsEYM0X
	 8gx7XzkCGmAnOouvRjyaGUrvWQY1FIKrgBGdrii8Mf+m47qJQs8igCxgwYp1AFigJbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TnWVhw7oZcSC8ZaN1cTnrD3rdt+VMkpcGZ3+QVDG1Gw=;
	b=ikJIM81Rr7c/hlqyLp2AXXd+mi1KQBzcjc+aWmmuDVgkaUaZa/dXr5LuT5QJDrHA4cII
	 CN3T57uED8+pQXzJ5mvn3ZfNGq0j0RpEXSOEvEyLPb4rbBRZ5oApSXwlONQlKE1qIoUT0
	 8na8QVWTKalXHX4/GWSM4vV515uKlDmNIpcv8VRjivVpdfBM9HceJSuwVZF5Pjhb0hwPk
	 9oCopWj6d5mK+EB/wYUYIgb4Kvf50HBuhpTCOExCxI1CsHAGn8V7khMCgYuIibQj3pUad
	 t6QU8+MWxiGPsg/W9na8iHVg8YDS+URZ5ynf2rV3KjdBflXxlSvDj3VDxdsLXpIn6LQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793809599;
	bh=TnWVhw7oZcSC8ZaN1cTnrD3rdt+VMkpcGZ3+QVDG1Gw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SqBOYRvdpndomCJSFNB9QknFR8btj+lUvywryrSvqWxpZVndW1OsWhydbbvL5eO8b
	 kod0bLs7mw61rGRCSQaR0cJRPeBsXA3qewwEWgGnpgST63Ci8urVlC3x3ENZgTKMTE
	 8KtsB/SQxhbsez9/qS7jzmVSADQQIb1WjHovHoskFxdlcZtkcZMNTCturPFPRc1ZYy
	 aaAYHanIQoEqsw2JeC7vxgfUJFnkiqidRH/kZgWsJVmf0V5BnJisV8wcXGoflH4OD3
	 dvByO4IcWBCQuh2Rw76xmSOKbeYafyOQ1Jfiy8c5mLyOrNK2efFGR7fjKPhWAyilIh
	 ZT+OlnWwAqEtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 397A340684;
	Wed,  4 Nov 2026 16:26:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 930D2280
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79BAF605F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8hchLXkIDba for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB2B3605B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+4dWsY3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PbTL8+Zw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB2B3605B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:26:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjQuO665009
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=TnWVhw7oZcSC8ZaN1cTnrD3rdt+VMkpcGZ3
 +QVDG1Gw=; b=n+4dWsY3VTHcFLBovttfVRZoOH9fRcmhmMmdPpJkQnpD1C9JZLI
 nyKjUz54AJGBWuODwGnG0Ax09s4dGOyi/BGRKH37qRhKqyh7g6fgpPgNk3zdvu7X
 OVWoL2kCKbfVxiPbOpXt1L2+8CGUoGDx6bBeVzCyWqkd9ZjQDZw7J4vhBQuuowKH
 Ur/+8VqdLaXGqFI9/4xRXcOc5+5WoMTLVhmywlz5e4tOOk0Ypc9F7xaX1pjTGq7q
 HCEc8i8/t8TFF21YW6aSYqfz5P7cECWH0bXJIJwCX9aWg0p46rnq9Q9ImrR/qhWn
 WxaBYnEIaAu7vok1r3AnooeYTxLZGzSCIMA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0avs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:26:35 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso1104110c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793809595; x=1794414395;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TnWVhw7oZcSC8ZaN1cTnrD3rdt+VMkpcGZ3+QVDG1Gw=;
 b=PbTL8+Zw/3XDfBCahUPrL1rj80ynhIKVSQlFbpnYFjt2sR1JxOlT+1BfQff4og4GUO
 wwt20WoI5pG14Y5R7QrBWD7C3h5mixopAIfhd8790I/Lf2LdLouQLG62jrOA68XHRyrW
 6aQH1Q2s6Z6Oo/E9ReFfvq13ZrrLz59D1SMYHCx7gvWuQURCUjdZBp9teVMrv74OqyQy
 MG7cmtIHrlDSJzl9yeQGbszV0RCOksRgo2/msyBvix4D4NIlgUZZonYGGwyVz0VJ7pT5
 34EQ5jdiHt1EpU+et1QqG7UGtLEc5G78R178ZLqVIXZ6yiQ+Gjw3RA+J/tRNchAVKXkj
 s/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809595; x=1794414395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TnWVhw7oZcSC8ZaN1cTnrD3rdt+VMkpcGZ3+QVDG1Gw=;
 b=bYORkYf1Z0hta4j6tPGm88noQYM3+TELzerI/vFwab4mMP3E8RvlWwTLwgqeYvL3zC
 lcwx09+/5+LFzQwrWqGXGZzWUL59oVDrI6TLO3DSyFxmYRR1kBrM2b2h3u0TvfGnULjp
 iZZNmS5+yUGYOrEShgrO2wqnJ2SCl3oLUWUmYSxxiWPMXSJVk6NcGUBclHBXdGBr3pXS
 Ldyokcd7yyV/kWnMwIql/+p7c2YKYfzBEKajaSG3ui3ELRimJ7kq0g16orU8DCJL+2gE
 GDysxPn4PjT28JJ0FXvs+CJzvnQ6aDMCwkwWM+0fkx0UUys5q4rnrGIpU+xa7J1Hr7Tq
 CwPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdGT0Vh1BMM/T3uf5n1qOEf1gK8i5N2jVGfsrri1TujlSm4oj1vsJtUqwWAMXdSiJYpagiZQk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+C/pj906eyrHKdal/XT8waN3X0BP8rg1V9ueMuu5RSjNxVsY0e
 Jqu+XOdT3lQQn99/qcpYQHiKwJylR6q3lrWU+i1QY6t8KIFBaSl95NHo7fSANDzMm5SFFyMzv2I
 5Kgn8O6rjEPLbDYYx1u1aWbdFe+F4X4lh2DEe2nW9BiQREVk69qe8RCpIh3OAv8bcjidwdJY=
X-Gm-Gg: AYBFou0hFLhsJsK/ni/BayIJwfKKCR8k9pNH4X4Fl9ChPDJcCEU3i1tc7fpmUkMTY2k
 Hazwj+xzPU9uxaXNCmc52AaHClFVWs1u0j81E3kcWoM0JfgEQFPIkciDbGvhDaw01HERf8KpcvO
 XKEiUVKgVswU/a1T7mLFiGG8+AuDuOxfEitm4uP+U3GH2VH28X7a00dniRRPEfVpugFOZJi8ULA
 /IL0yN5wMrU02ehmlAUtahnS4av6SFfpdCsIQfHqm561YX1S1ta5ictW3cN4Yh9DP7AcQxTtIL9
 hMyqkI/tVQhSaVNPWG4WYhZyTBfSVO8C2T0RnldbhUcWbfLUlbTi22QPQ9fx9gLWD50vbUCL4kV
 hYCJ76MM+VP4VWMoEKYM+ZSaUkJbrxi8XzAfDKYGNTNTVpadQmqE8VvQiusAFHL0R9tx5Sb5Xn/
 xJ4FGaK3iuFh37bBTinxKvCFAIkQczJdh7hp/gSoNuK3HOD3SDaQ==
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr25550346c88.15.1793809594656; 
 Wed, 04 Nov 2026 08:26:34 -0800 (PST)
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr25550306c88.15.1793809593914; 
 Wed, 04 Nov 2026 08:26:33 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm10637142c88.2.2026.11.04.08.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:26:33 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: neil.armstrong@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] pci: pcie_dw_qcom: fix clock/power-domain bring-up ordering
Date: Wed,  4 Nov 2026 21:56:26 +0530
Message-ID: <20261104162626.1244225-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX2Oaraqpa00YL
 TJ7hBnsaIixkGIRmD5Y0zAyIv17GL+MsagN3Egr8FdqpbmSO090HEU1zp04rCFb/2lSzbxkmTkt
 xS95LqeM6ezMaFqrv/Rb/idU74DDX4o=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb5cbb cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_FAiuXUYnpk9rfSQLM8A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Vg5giDygJQbCE-2Fe2sG-VZj_j6HUkm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX4I64U7TSBFgd
 4f69lvXeeHx+TAJdM/z+4qlLXQUIh1kP9UjZpyQS2RDxoWRm6/2wEf3pXDx7xzKCQREF1RpQEdm
 YLcGy6ETw04zBqgZP4uTgpNnNvsGJ7QsFwi+iwWIPX6kPIKIOs9pb6C1KIbIzewUVXoX7T8+HAv
 +ZSMVmoQRMMFIzQcGre/LRzkwxzBP3IFy2SnlQFj0o/45/d2rQNZ41W8z2mve1pDQjFimnCiIWC
 BaIUFY1oqknOzkKp2liahocw1627WMaqHMaCMMSaRPv9Jk5n+jlxSoX0wn0olkrNA+AieH3AoX/
 OCvif8o8RxUMbRJhRtG5DYABypMCHBvv5u9og1HASMG2vgFMbhs8PTABJeiVa/Kq5Uy7QAwchtx
 9WayJ/Z9nEGrjOHgHML34eND4nGk+CXhM3X7WH9B5A+YzoniqfgFIUUSw2QrA2mbmB/YiAOeG1g
 /kqjXhqhLR1+mj6Kh9w==
X-Proofpoint-ORIG-GUID: Vg5giDygJQbCE-2Fe2sG-VZj_j6HUkm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040065
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

Two probe-ordering issues in qcom_pcie_parse_dt():

	- clk_get_bulk() aborts and releases everything already
	  fetched as soon as one clock (e.g. a not-yet-registered
	  PHY pipe clock) fails to resolve, even clocks needed earlier
	  such as ones gating PARF access.

	- The power domain may not be enabled yet via driver model
	  auto-enable, and PARF access while it is off aborts.

Instead, fetch each clock individually, tolerating -ENODEV/-ENOENT
for clocks enabled later by their own provider, and explicitly turn
the power domain on before any PARF access.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_qcom.c | 43 ++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index ce6b4d97d1d..863bc601f49 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
+#include <dm/devres.h>
 #include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
@@ -415,6 +416,7 @@ static const char *qcom_pcie_vregs[NUM_SUPPLIES] = {
 static int qcom_pcie_parse_dt(struct udevice *dev)
 {
 	struct qcom_pcie *priv = dev_get_priv(dev);
+	struct power_domain pd;
 	int vreg, ret;
 
 	priv->dw.dbi_base = dev_read_addr_name_ptr(dev, "dbi");
@@ -448,10 +450,43 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
 		return ret;
 	}
 
-	ret = clk_get_bulk(dev, &priv->clks);
-	if (ret) {
-		dev_err(dev, "failed to get clocks (%d)\n", ret);
-		return ret;
+	/*
+	 * clk_get_bulk() aborts on the first unresolved clock (e.g.
+	 * a not-yet-registered PHY pipe clock), dropping clocks
+	 * fetched earlier too. Instead, fetch one clock at a time,
+	 * skipping ones not yet available (-ENODEV/-ENOENT), which
+	 * are expected to be enabled by their own provider later.
+	 */
+	int count = dev_count_phandle_with_args(dev, "clocks",
+						"#clock-cells", 0);
+	int idx;
+
+	priv->clks.count = 0;
+	if (count > 0) {
+		priv->clks.clks = devm_kcalloc(dev, count,
+					       sizeof(struct clk),
+					       GFP_KERNEL);
+		if (!priv->clks.clks)
+			return -ENOMEM;
+
+		for (idx = 0; idx < count; idx++) {
+			ret = clk_get_by_index(dev, idx,
+					       &priv->clks.clks[priv->clks.count]);
+			if (!ret) {
+				priv->clks.count++;
+			} else if (ret != -ENODEV && ret != -ENOENT) {
+				dev_err(dev, "failed to get clock %d (%d)\n",
+					idx, ret);
+				return ret;
+			}
+		}
+	}
+
+	/* Ensure the power domain is on before any PARF register access */
+	if (!power_domain_get_by_index(dev, &pd, 0)) {
+		ret = power_domain_on(&pd);
+		if (ret && ret != -ENOSYS)
+			dev_warn(dev, "failed to enable power domain (%d)\n", ret);
 	}
 
 	ret = generic_phy_get_by_index(dev, 0, &priv->phy);

base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
-- 
Best regards
Sumit Singh Dhami


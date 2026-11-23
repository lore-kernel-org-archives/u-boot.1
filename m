Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CF606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QlqgQv2K;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AVYoziQp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GTasfZfZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEC8B80D7B;
	Mon, 23 Nov 2026 08:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1eINLiwAJfl; Mon, 23 Nov 2026 08:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ACC680D80
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795423810;
	b=WZDPPsec9Zx/Gh3K3ZQYs6NFwgliHFSM7WWbFXQqohUNerlOeXuznrzD3ZyqC6VP0sAM
	 w7dF77CUCeWXdHfanGmRciPoKcsoI/GSjseYIJ2o7NRzD9uwLfAbl6WAuWGXCzbI/iRxU
	 flF0PUZJuettV62pz6onFAByzrb8h63COqESvCZctINhCh42OLqJvCVriFFVIbz8CuV23
	 W0AVGkcKoVnuQ1xflbKd1oWr8Co0sOI/8xCDP3XRmpQF6GZoefCpp2Wd9T8qT/xwOHk6t
	 LzHV0UPjLgZm730BV0gFR6Ngx1w+si4FzuowaZ6BtdL2iJ1tdpsUNqzrX5FrImp5VVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795423810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OGXXvuah7pENPSW6pjNuvxh2JpFgr/768XumZNln/Uw=;
	b=UihkOz8jrc4kvpqHp6/FRBLTEJ7Ci2uYNdwgPVzyN8UPErP2BvM9wP9duDxY2LhLgm+V
	 8eiG005E9rOFgiHvmEOCuI5U67Q2BFn8Pg0Mk/fbaMwl+FX2upFsNZAgl9yOycBny0/4o
	 8Zfw94ex+Y7D7JtOADE9Y3HaKqdD+h4mezFWQKp09NICIoFvuSWHewcMKlbuVe3iIZipG
	 DjCtGaddqSYg2N4oJcUdhcvexDc3YScDCIzgphruD61VUpJWAY5r9yGjiN7EHCZOpjFRm
	 9QfAwuReZ6CNW5plHwDmdw9/eNnTAUhzaAM3xkbjD/feCfiQ4nSl02vaV9tkGV9IBxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795423810;
	bh=OGXXvuah7pENPSW6pjNuvxh2JpFgr/768XumZNln/Uw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QlqgQv2KkgU3wY66rVv5OeDQV4jTP+BTR5Opps6pTnoyUnL0MQrFZm4grl6eJEEys
	 d3AmzR3evwKFbdIlYxbNgt81aC9ynRribSSXb5RBLLD0aWQRW5mzbA6Ck3Oz6QKZOg
	 y8W0ZPJwrPKKawOvymnd/E3QTbRhobSH/zyJ0TmKPv0O9YPoNZqMB5f+5BIpicXQ7R
	 +9KGwlwBWVfpAnfXEZRAG9weMPJIyjI8/ueJ12Mizop6ZJcZ71V49hqNjlcGE4JFM3
	 dIF7KZdBL37dlAsiRCCq+NpXhoShhsxgmcQpyYiZrLXVYtOWu5t0r099XDezhtCIpu
	 6PK9v9l1n5lSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ACC680D80;
	Mon, 23 Nov 2026 08:50:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BA751AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 419B3405F9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWTfTHsefFrj for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA9A3405E5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=AVYoziQp; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GTasfZfZ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA9A3405E5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN683Ks1126534
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OGXXvuah7pENPSW6pjNuvxh2JpFgr/768Xu
 mZNln/Uw=; b=AVYoziQpNRMskx04N9U+BbTGcFM264J3V03rftr4zCKEHI5NcF2
 QF7g05Mg4Uo/KKWC6GSv3flJXEGO242vddMi3A36tJwMHcRZoxkyoMNsOaLmkX3N
 XnPeeAP1mfpiJOV+rDnkST46CHNP77SmEf/ywpErr8/bTPOcUqWFEzBAYQknjoRz
 BpnW9MziWaMIdrjV+EezcDCSXUwqc3CAODzZRWVwc87mUTyR2WXVPRrq8V/Nqqek
 +AYg7sSE6z5ez4nbtBYv/cDGP0SlTgt8fUaB8GPknUIGVMlD8lnzcdYVxmZTtWGk
 oznyaVRd4HSMWwA1vZLlV9MCCl29d6jH1Bw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00jgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375bac6bd21so3505841eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795423801; x=1796028601;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OGXXvuah7pENPSW6pjNuvxh2JpFgr/768XumZNln/Uw=;
 b=GTasfZfZU8ArXRSSS0dap2ZVdIvVqYd9C5MBkZ9GoBquaYovvhNHBWEejfVNQGe+PO
 3JECxBmTmBD+V2c6blhi4/cEQsjDld6s2MlbZeFwU9CB0GtPDMeadXKQDITqME5y2YMr
 zlbrn+59bi5BntJ+knBEsblVrgcBRY11+Of68WGHVy5C1kAm3nEa+ydop1IqrL/628gf
 LfOoba9TBLjKu+rTt5zNpqKvQY8EiRUsInnukDEJC8plJYOQGUcim5SX/2UZprOj//yn
 ifY+rcMF5jQjFKvHjzljL/aTCtUjrjMpep6aoQnYgYhEcBgeB8RJbhDE2agekioIWm/f
 C9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423801; x=1796028601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OGXXvuah7pENPSW6pjNuvxh2JpFgr/768XumZNln/Uw=;
 b=sdFR9TNSw2zO91wY1O1/oDVGbGkA9XCYOWxP/n7Ho53+mIxfELBl626Mwn9dOvxsfd
 J5q6+sdfyB0F6XHlQowMlLOpgXjTHXlCiunZ47ZS6bhzKpaWoGojFMDo7bqoHDi4VmnN
 aOXZdKI2GlFDsGjnAjekYmCnCM35KzaVoEQhRK6Lzt/L/WlDuAS+dsHPTiHZ8DE0Qcc1
 7WrvTmylwvcyo9PQuGjEMuJ+0hHl6R0a14LKuZfXl4wXXFhH2AzGdyD0772Pnu6muWCv
 1z+yvOAvxut1fMSwNuSKyq/0kvIPl1TZ8uvWT3A8xWcXumBPrgT7NbPpbbBruSmAUJws
 bxYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEJ/uLwjc44CNELN1ZYll4o/H2vBGOY2F32+CDcxS/2RNKbfMhtPQuMoiI+VsE2qhEUmqgX/BI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83oZ0g6XAirVNY2zm7hMR6dtPgYe7eM33NDogqvsAJ8K9oR8xr
 nUwh7/4aICHSV+yjx6I6fdI7PByK8nKAmG5l7A+CBgp0zuTRbLcrIgnAayZxTWGljK3Q0IMF72h
 l2HaTcUKuE2flPc5DmTmvQEG/NJQstW+XL42Wj/ojnU2rgjXH+JZIAdDQwn1RizEzroLTfd357V
 6TthE=
X-Gm-Gg: AZFdTZdwBg9EvigRLxDHpL2qxc+GCrpSog4jm1kT0G2Kyv/sVj/vtH/iX4tNWtrpjeO
 dGa3dlNaWRoztA6RFlxVjWOwQlbalhN9sumzvVsp8irWraMdx/1w2K/Vq/a2MTVQ7UqtLylFFKF
 4pFmjupxYePc9EtTcAKryQxAXuhYXNZFov8Qg7uDPf3I/4FLSIbHlAGq0K4OM0wlN1v9dyGL0cA
 hpMNGEJt028Jw+xhUMH2VCo+BTzu8ywgswnZRPyyPLY5jduFv4z6DK1Bb4rDfoE8OEHL9U0/utZ
 nE/25+9bMhliFY8u2upe38fJ3CE3Kpj1Vb29NC/e1JWxbL7ADdE/b9aur/u+PGidijBuCgCezYs
 HZAInTFYKf+XvEowZd3JldVy7HPdLWM1wTYI8hYrLv22I0xhJmhCTLx+qySYK+tbaK1tHWnDsNM
 nfEO76rnOMbjgh25hbA+2u704OMB24OREikEnlfa2XFBEn1MxPw6q8lAzARauNrmDKkcGi
X-Received: by 2002:a05:7301:182e:b0:386:1901:d994 with SMTP id
 5a478bee46e88-3861901db11mr9645004eec.5.1795423801067; 
 Mon, 23 Nov 2026 00:50:01 -0800 (PST)
X-Received: by 2002:a05:7301:182e:b0:386:1901:d994 with SMTP id
 5a478bee46e88-3861901db11mr9644985eec.5.1795423800439; 
 Mon, 23 Nov 2026 00:50:00 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386aaae4960sm10822359eec.18.2026.11.23.00.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:50:00 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] PCI: qcom: support PHY and reset GPIO in Root Port node
Date: Mon, 23 Nov 2026 14:19:37 +0530
Message-Id: <20261123084937.3936584-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXzonC0JpBu01p
 h1f8H2L0HEOoiB6AYsB9bKEZEkM9+I5rwxoGRWsiAzbOQH1uZ4dbj/bud/IA3/G1uz9ctJNod0/
 q6by79/ltMmEZ/lxs69G7zFCwLemOtTigChoSTT+XEUc9OEvl/7QG55pv0VY2OkAQRr8TWonn/B
 teXRZcLWO0Rbj0xCgB39zW/+Kz7m6Ch/oYCLHgxw3ZgWmHlhZ5TwUZuXFNILmuHQoyjHO955mc4
 RzkO+XvqXk5nQLQYuXI7aqslx6cokQbEveKNBYC0jA3eimfkLJIKKjdiPjuACXP5UB59vD2iaK/
 uRiLpd1DKq86iPviNnP18XZytc6vUEefm9JTnbrjY67FpRKnyZv7E7n0GHpFgIOwI9M0auoILBP
 1e1F7HGWPWhsfBqtsuuRqbVMnZHHS/0xy2FzzILgHKAuoLcUFwlDqzzLp8L40m3e7gz8erdGpWF
 qAGFFNCzoz/EcTdYcvw==
X-Proofpoint-ORIG-GUID: 9EZybZ5oKxZpAWWdiavTzrLcua9RVjCv
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b03fe3a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Sv6W8SihIXkM6Org9FoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 9EZybZ5oKxZpAWWdiavTzrLcua9RVjCv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXwFjXqB4xWgCc
 UrHq4cTGjIyGxhiTfuDOpytcmRnqGbKZ2akdV0csO+GSWVYSXZJfoWhPt0UkTlZvQZmC+HxqKld
 LW/O390Dm11JnPB4RM+1eJsHXl8PNLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
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

The Qualcomm PCIe DT binding moved the PHY and PERST# definitions
from the controller node to the Root Port child node, renaming
perst-gpios to reset-gpios.

Look for phys and reset-gpios in the Root Port node
(device_type = "pci") and fall back to the legacy controller-node
properties when they are not present.

Also add a remove() callback to release the PHY and reset GPIO
resources acquired during probe, allowing the controller to be
cleanly removed and re-probed.

Based on Linux commit a2fbecdbbb9d7 ("PCI: qcom: Add support for
parsing the new Root Port binding") in drivers/pci/controller/
dwc/pcie-qcom.c.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_qcom.c | 74 +++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index ce6b4d97d1d..b6546d43164 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -415,6 +415,7 @@ static const char *qcom_pcie_vregs[NUM_SUPPLIES] = {
 static int qcom_pcie_parse_dt(struct udevice *dev)
 {
 	struct qcom_pcie *priv = dev_get_priv(dev);
+	ofnode port_node;
 	int vreg, ret;
 
 	priv->dw.dbi_base = dev_read_addr_name_ptr(dev, "dbi");
@@ -435,11 +436,43 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
 
 	dev_dbg(dev, "PARF address is 0x%p\n", priv->parf);
 
-	ret = gpio_request_by_name(dev, "perst-gpios", 0,
-				   &priv->rst_gpio, GPIOD_IS_OUT);
+	/*
+	 * Newer DTs carry 'reset-gpios'/'phys' on the Root Port child node
+	 * rather than on the controller node. Only -ENOENT means the DT uses
+	 * the legacy layout; any other error is real and must not fall back.
+	 */
+	ret = -ENOENT;
+	ofnode_for_each_subnode(port_node, dev_ofnode(dev)) {
+		const char *type = ofnode_read_string(port_node, "device_type");
+
+		if (!type || strcmp(type, "pci"))
+			continue;
+
+		ret = gpio_request_by_name_nodev(port_node, "reset-gpios", 0,
+						 &priv->rst_gpio, GPIOD_IS_OUT);
+		if (!ret) {
+			ret = generic_phy_get_by_index_nodev(port_node, 0,
+							     &priv->phy);
+			if (ret)
+				dm_gpio_free(dev, &priv->rst_gpio);
+		}
+
+		break;
+	}
+
 	if (ret) {
-		dev_err(dev, "failed to find reset-gpios property\n");
-		return ret;
+		if (ret != -ENOENT) {
+			dev_err(dev, "failed to parse root port binding (%d)\n",
+				ret);
+			return ret;
+		}
+
+		ret = gpio_request_by_name(dev, "perst-gpios", 0,
+					   &priv->rst_gpio, GPIOD_IS_OUT);
+		if (ret) {
+			dev_err(dev, "failed to find reset-gpios property\n");
+			return ret;
+		}
 	}
 
 	ret = reset_get_bulk(dev, &priv->rsts);
@@ -454,10 +487,12 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
 		return ret;
 	}
 
-	ret = generic_phy_get_by_index(dev, 0, &priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to get pcie phy (%d)\n", ret);
-		return ret;
+	if (!generic_phy_valid(&priv->phy)) {
+		ret = generic_phy_get_by_index(dev, 0, &priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to get pcie phy (%d)\n", ret);
+			return ret;
+		}
 	}
 
 	for (vreg = 0; vreg < NUM_SUPPLIES; ++vreg) {
@@ -515,6 +550,28 @@ static int qcom_pcie_probe(struct udevice *dev)
 						priv->dw.mem.size);
 }
 
+/**
+ * qcom_pcie_remove() - Release the resources acquired by qcom_pcie_probe()
+ *
+ * @dev: A pointer to the device being operated on
+ *
+ * The GPIO and PHY would otherwise stay held across a device_remove() and
+ * make a later re-probe fail to re-request them.
+ *
+ * Return: 0 on success
+ */
+static int qcom_pcie_remove(struct udevice *dev)
+{
+	struct qcom_pcie *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->rst_gpio, 1);
+	generic_phy_power_off(&priv->phy);
+	generic_phy_exit(&priv->phy);
+	dm_gpio_free(dev, &priv->rst_gpio);
+
+	return 0;
+}
+
 static const struct dm_pci_ops qcom_pcie_ops = {
 	.read_config	= pcie_dw_read_config,
 	.write_config	= pcie_dw_write_config,
@@ -547,5 +604,6 @@ U_BOOT_DRIVER(qcom_dw_pcie) = {
 	.of_match		= qcom_pcie_ids,
 	.ops			= &qcom_pcie_ops,
 	.probe			= qcom_pcie_probe,
+	.remove			= qcom_pcie_remove,
 	.priv_auto		= sizeof(struct qcom_pcie),
 };
-- 
2.34.1


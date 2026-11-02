Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45168606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F2mcH9XP;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PL/IYHG1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IXN6TyKC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BF9140693;
	Mon,  2 Nov 2026 05:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUQ0_2csg6zn; Mon,  2 Nov 2026 05:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4141405ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598645;
	b=WrPRJ2vFPmm5weywjiN3XmXgWUHa5PHxAp2zpcsW87hJn74FCKJh9KkkZj7wFMiowla3
	 96zX4vKuoSH0VEh+e1RnX2wWIpZ1J1j4W1boVkLYhMZKsGad4Rg+lJghF9bRxTMUOmELy
	 rjL3tRteIaEBbcN3ZzKSkk7F/zr5up1D8rZT5zo5c0Cpz6PaJSaayZGetHuuRqRgDmN5l
	 6HJVx+FPqrwP9S++TMjM4gVclzCftu8c/AY/7kcKz8Ew/jAun0xkAgks7se3ZlGbe3ucu
	 Y+7THcFYZ/tN3eHHN4OnSkFH5VqK2oZ6ZIEmNuKpgeKFMXfbeyoIQthsOG8h4KHIc+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
	b=ZkNIsxEQ0Hs4R5NxNRfazFdiHwfSRoNIJObPccdax403zd7bFRhdw7ayxBn6ZvfBbQyK
	 I3/wqoG3n8pH0dFSX1LK1YPXq6oJb8rbcWo/dT/ghXlT9ZwrP8oMVqt0gKqVEeSxjvKj5
	 yheo5XNFD1r/ysJz1jszrKI9SdZ0HqFyvpOd99glyKPqOc+g3bdmXMvbUafuLu7eCoBVn
	 nnd/UfUQjsdUPLXlNdaOULXarUofZwBQH3kEiw/KldijOpMYZi4UzJoL5o3+wveeVxtR0
	 6Dpu6zyLplv5chFLy7H6mRVeJ4stOgibdy6/Hb8Mvmly/FFxrBcqPM5ir1MgJjjIBdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598645;
	bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F2mcH9XPLBQa9PC+mW8hqSiD+imwVkKNwq39kdEKRMK/zVxvBngTNUANOGqWDXlPO
	 dQtE6bGbe4DWmd9StCD5+4xvAxT64E7wel3BfZMdmIfx1Inak45fQwTGXFHqBoX0QH
	 /nM752XMoTHEEyVBphgBwSHxHIfj37oqcpxhVl2lc+TrfguxuHU9j1lTvBtqZrZGee
	 dypIingsPWr2TxrS1KXB1iSQgMCb+EYEybB33J2yA5UPg2OE819jo9ynE2f6pwbXQf
	 uXXPARvGaqQFXh2459ax0dICzHjrQXXqZ6jxAuDCPTqCBuDEpXMHWxm+njKa4qSZPn
	 mEcm7QGT001SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4141405ED;
	Mon,  2 Nov 2026 05:50:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F86435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BA4A400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZuomKNYtoOFc for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EC6A1400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598643;
 b=jbHtX1c1zHPpWkaBT0p7L7CjiQAqHa/hg9cSjtyh68pJS1HEL0LuZtM7aYD6Tr1gnVFn
 3mOdtitqiL+5Lx3Yh34+YNXM3vASdxCbVkxZvVYjYelTAo33KJOkyWZLApkllCQws9zRI
 dBIc8jRgK/pc75BlNU3/IpdrwQwh4a++cNriYfm6yoXNRPL0ewytBVRXT/totc/K/6IhM
 GW9+cRB7hcRVD378U3G8TBliGx0fW6QBWgMMefsT86YmhPwaTNzwDnMk2V5/A5zdVGWRK
 hVLNRdnzlrbKv3oBRzUk6yQSw4ov1zVOXOdeahxTtwC0hVyi6DJsVzHhIWpQVyL53tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598643;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=ME55qR1bw0C7aq8fTwxKnGNAcm1dXYSq43eKFUBVilTxS1Dt3hAXCzhxDato/eU1XiHJ
 CZ61aDXl0pjX/iOOAZL3zsgWwrfYfUqlpL94UtXoKguinoOMLDhQxr6cE4efwa9Ypcjky
 s0TATdlwb5iE4y3isJGZh0QUHCaAAExjFsBG1ufEYXxN1sEkKj/cSl44LclBGdn6A2NaW
 aWkFqnuU76cwaU92zIH1XIu+i8DNR66jJLG7qAQlNb6yUE/GirOEdY/aNZ1qzqZ9YvpWl
 +TwttQx9U/UfWzdkXVllM0psHV6egZYLnBewA8H3a8gQeIf6QaMP6RVMmH4WfRJnKtw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="PL/IYHG1"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IXN6TyKC; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PL/IYHG1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IXN6TyKC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC6A1400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vWdx2746314
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=; b=PL/IYHG15nsljV+/
 dRkDUNqo9WwSOjUASdcVCt9EUZ2g8PFfPyr+65WV+1INXvcCedkEByCJWfY3icPO
 zPsigd1+3jpCwi0iWqz3yJtCV0+j+rgnI5LzV+1RRWaWgHd4YoxN8L/7eXoXrsnY
 zDbAIsdSBBJ3WMqKYVKyr4M02wxLsuFMs3l59ghSd7WIfd62Q6PsB467KI1dyEaK
 VSRaNnFAs9Jl+RTdsQ0iij5jg6JFR3Rn3s2mdAaOUsVmRMeEtYlWhkWPXPSa1ojn
 FiL4L+aeJMsNmPkZKcoP4dTgHNJ4IqsrvqhaHxFMAK4fLQlSTmRlXlAqYQDo/t0t
 zs09Pg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dudaxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso451164c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598641; x=1794203441;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=IXN6TyKCjq0h4IguzR6FOSMnuvZULjjWwgdsIrDYKjHM3pjic0NYmdb3rq9Y2c8XEg
 u+FTfVwlH+pQ6nIcK2atkUFFX5/ceD0wsM75FOVUYEQfaVNVc1uj74Bygnw6wvIgGnlu
 olVgDbmfV3dXYD+xWe5LryIw6EpELAhuxChJPX27tnZCkDZZoccnKPWL3zIktxK++HH4
 CUyxw2S0e0NkaSFA2cJj2yVcUTsunAgLNbcQc0W/1mdvepdoxBPZGpLd9/4eBebzWKDH
 X8+074oQrzLY2WR09Sid8MJFdWIGiSbBDmItqXPqROPzgKgutafx78yrfRhatlGn/oed
 sSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598641; x=1794203441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=wU/qtxLEMYkZTaQcC6moj41rU7JW3mAzw83O0diB2PTB1HOsc9UqEoXKHbyrzEM/jp
 X1ydehaRmmll5od9esvge/Dg7EZqlXPGYL46F4MsjQudPDdxIfT4Jp8Y77s9StTd7rZr
 ByF/Dcb1LQAuXaEoOuCPzt1DJlZcogS1GzcPvRHE7SyZYWqO9mwjXIGq9viAG2jsb1K6
 TcVg2TMEprIcMTulZ8PPI3004v6amIioos49QCc2of9rMiOD3uhvwXSX0FiXglPTKnvH
 ywcGB34IVrvaGR+LbWQmeRiBPOLyuIS8wNJUA1S0HhQ4WnCYdIXv6Km6gSN6HVgp/mr7
 pAoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxD1duXxFKgNdyw6oMyJhyTF3faZ1hF+ucnhwmhX8Pv7SDiRZuvclqYqKde7gf84JfhYhOf6k8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKzpniMxbfgOmv8hds/rcr2BeL06NZIi+MKpSw3QAbEGRl9Y4DX
 AIwClrT/f/iEMLz9sdSpnVf0rHeD2TGYKiDJ6FL0Let+6eZRAA6JtM2clU9kHWOnrHAoHobI5kl
 4wSxADZ2/oMnpMzVRVR4xBn/VlvyvaGTG9cUb3oF1h6ojsnDnbvyBL9ELhU+c885pUqiem0w=
X-Gm-Gg: AYBFou1GgTbCyfmhCanVvetAl+/6jrQ122E5crE2zt1mtN0w5hnZTvaGVaTpx0AmBYd
 zH5AksRUvhq3cRAO2MXnDxioqm0fiSFvnoOJNWKv1T6M7CwmeF6QDVSm6AT2+bY/ARnSm0FzeOT
 aBK8Gv7Ben/gu6gIsTKp67jYSZVwky7hJV9vkTqWd82bGPxBaTeix1OpOEKEFN4RoT+7UwSi6fn
 mNrtHI1ky2+ji/ics3g2sse9bya6f2DKNSezXeP/ZPdQKLCxTWX+P328CPEyCLQ2iKWmx1Y/YGL
 b0E8B5TYyqpdTDn3oPOVIc+h/ZeEX7VapME8EMUQmrcZXa9J2iY5PMWlVyJjSK5J+ahriZkKUPo
 lQ4KP0M5GeRSaCoNB4AoIgG9p8x5EEOnsOOU9HzTymckgU8pEwDSR22IOxmzMya+TL76O0TsU6K
 3hBDHdvBlRMO14cCAzmtOTzxmgrK51rkvo7586I7pp4s9wZHu+QuXsz//G+2kfhp8HHjkQXFhgn
 /QYuw==
X-Received: by 2002:a05:7023:90b:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-1ac5e6f5132mr17361997c88.24.1793598640195; 
 Sun, 01 Nov 2026 21:50:40 -0800 (PST)
X-Received: by 2002:a05:7023:90b:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-1ac5e6f5132mr17361944c88.24.1793598639430; 
 Sun, 01 Nov 2026 21:50:39 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:38 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:44 +0530
Subject: [PATCH RESEND v10 12/15] pinctrl: qcom: Add ipq5210 pinctrl driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-12-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae824b1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NzvCGKM8m0lGn9t9IsgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 2CLWN8wG79qsfxd6_I5bSP9ggn1GmfpR
X-Proofpoint-GUID: 2CLWN8wG79qsfxd6_I5bSP9ggn1GmfpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfXzgzdJUuyYPKs
 /nHrXLxQ+g5KfxfKI5aI3BbPHIrE/3mlknyxqKohP8FNIm04TGh8zDng5zgoiG8FY9PyEgJpYsp
 o7KCO9DaJGK0CYgCgXHvZ7EXdqT/2cx9J1UeVe+q44erMH6ikZmNzbZijIwz7OSYgNZmNA01Amv
 3EwBVRD1thHUAVQfnsQy8Ulh3OTK5stSeox89vENSqWQG4ULvvfoJIKia4FxJ2kvViYjdEho3UY
 /otnftXy5uOp4NYqHYJME1U+st33Ortu8bbMK0p4V+p2PJvwOjksk99JiftMmuMDnR4p74wVxgS
 JXp9u4i6KyjhNvHdhgf0qLDyV5S6LvoANMx1cnMwtJR7yFQ0ivdUI2OEZ/RjzUjnAVoTEF72qBW
 2bkAaBt0T4yCjaj5eFVWMyGQl45SkkAB7YQh4LIFnKTuW2DJrqWCpp57B99e9ww1ebkTnt6uRgS
 I8hU7AbLOkzKSwa3MBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX9LUPtadiR7Nt
 s0bfOsAcqIFl4HW5HupIMnotSHEjTvO2p/ZcspvtmAkH/BTjU1caNYKyRfGAm2jXUj7iJ26UcU6
 ZKrx/F/GyGxm/uRp+z6DF93vVpvPcRU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

Add pinctrl driver for the TLMM block found in the ipq5210 SoC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c | 349 +++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..dbb51cd7fe6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -38,6 +38,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ5210 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..9fe32fb8fec 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ5210) += pinctrl-ipq5210.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5210.c b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
new file mode 100644
index 00000000000..a9b435ad543
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm IPQ5210 pinctrl
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq5210_functions {
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri,
+	msm_mux_audio_pri_mclk_out0,
+	msm_mux_audio_pri_mclk_in0,
+	msm_mux_audio_pri_mclk_out1,
+	msm_mux_audio_pri_mclk_in1,
+	msm_mux_audio_pri_mclk_out2,
+	msm_mux_audio_pri_mclk_in2,
+	msm_mux_audio_pri_mclk_out3,
+	msm_mux_audio_pri_mclk_in3,
+	msm_mux_audio_sec,
+	msm_mux_audio_sec_mclk_out0,
+	msm_mux_audio_sec_mclk_in0,
+	msm_mux_audio_sec_mclk_out1,
+	msm_mux_audio_sec_mclk_in1,
+	msm_mux_audio_sec_mclk_out2,
+	msm_mux_audio_sec_mclk_in2,
+	msm_mux_audio_sec_mclk_out3,
+	msm_mux_audio_sec_mclk_in3,
+	msm_mux_core_voltage_0,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cri_trng2,
+	msm_mux_cri_trng3,
+	msm_mux_dbg_out_clk,
+	msm_mux_dg_out,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_led0,
+	msm_mux_led1,
+	msm_mux_led2,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdc_slv2,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_mdio_slv2,
+	msm_mux_mux_tod_out,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pll_test,
+	msm_mux_pon_active_led,
+	msm_mux_pon_mux_sel,
+	msm_mux_pon_rx,
+	msm_mux_pon_rx_los,
+	msm_mux_pon_tx,
+	msm_mux_pon_tx_burst,
+	msm_mux_pon_tx_dis,
+	msm_mux_pon_tx_fault,
+	msm_mux_pon_tx_sd,
+	msm_mux_gpn_rx_los,
+	msm_mux_gpn_tx_burst,
+	msm_mux_gpn_tx_dis,
+	msm_mux_gpn_tx_fault,
+	msm_mux_gpn_tx_sd,
+	msm_mux_pps,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qrng_rosc0,
+	msm_mux_qrng_rosc1,
+	msm_mux_qrng_rosc2,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs_n,
+	msm_mux_qup_se0,
+	msm_mux_qup_se1,
+	msm_mux_qup_se2,
+	msm_mux_qup_se3,
+	msm_mux_qup_se4,
+	msm_mux_qup_se5,
+	msm_mux_qup_se5_l1,
+	msm_mux_resout,
+	msm_mux_rx_los0,
+	msm_mux_rx_los1,
+	msm_mux_rx_los2,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out3),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in3),
+	MSM_PIN_FUNCTION(audio_sec),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out3),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in3),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(cri_trng2),
+	MSM_PIN_FUNCTION(cri_trng3),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(dg_out),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(led0),
+	MSM_PIN_FUNCTION(led1),
+	MSM_PIN_FUNCTION(led2),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdc_slv2),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(mdio_slv2),
+	MSM_PIN_FUNCTION(mux_tod_out),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pon_active_led),
+	MSM_PIN_FUNCTION(pon_mux_sel),
+	MSM_PIN_FUNCTION(pon_rx),
+	MSM_PIN_FUNCTION(pon_rx_los),
+	MSM_PIN_FUNCTION(pon_tx),
+	MSM_PIN_FUNCTION(pon_tx_burst),
+	MSM_PIN_FUNCTION(pon_tx_dis),
+	MSM_PIN_FUNCTION(pon_tx_fault),
+	MSM_PIN_FUNCTION(pon_tx_sd),
+	MSM_PIN_FUNCTION(gpn_rx_los),
+	MSM_PIN_FUNCTION(gpn_tx_burst),
+	MSM_PIN_FUNCTION(gpn_tx_dis),
+	MSM_PIN_FUNCTION(gpn_tx_fault),
+	MSM_PIN_FUNCTION(gpn_tx_sd),
+	MSM_PIN_FUNCTION(pps),
+	MSM_PIN_FUNCTION(pwm0),
+	MSM_PIN_FUNCTION(pwm1),
+	MSM_PIN_FUNCTION(pwm2),
+	MSM_PIN_FUNCTION(pwm3),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qrng_rosc0),
+	MSM_PIN_FUNCTION(qrng_rosc1),
+	MSM_PIN_FUNCTION(qrng_rosc2),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs_n),
+	MSM_PIN_FUNCTION(qup_se0),
+	MSM_PIN_FUNCTION(qup_se1),
+	MSM_PIN_FUNCTION(qup_se2),
+	MSM_PIN_FUNCTION(qup_se3),
+	MSM_PIN_FUNCTION(qup_se4),
+	MSM_PIN_FUNCTION(qup_se5),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los0),
+	MSM_PIN_FUNCTION(rx_los1),
+	MSM_PIN_FUNCTION(rx_los2),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq5210_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(1, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(2, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(3, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(4, sdc_cmd, qspi_cs_n, _, _, _, _, _, _, _),
+	PINGROUP(5, sdc_clk, qspi_clk, _, _, _, _, _, _, _),
+	PINGROUP(6, qup_se0, led0, pwm1, _, cri_trng0, qdss_tracedata_a, _, _, _),
+	PINGROUP(7, qup_se0, led1, pwm1, _, cri_trng1, qdss_tracedata_a, _, _, _),
+	PINGROUP(8, qup_se0, pwm1, audio_pri_mclk_out2, audio_pri_mclk_in2, _, cri_trng2, qdss_tracedata_a, _, _),
+	PINGROUP(9, qup_se0, led2, pwm1, _, cri_trng3, qdss_tracedata_a, _, _, _),
+	PINGROUP(10, pon_rx_los, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(11, pon_active_led, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(12, pon_tx_dis, qup_se2, pwm0, audio_pri_mclk_out0, audio_pri_mclk_in0, _, qrng_rosc0, qdss_tracedata_a, _),
+	PINGROUP(13, gpn_tx_dis, qup_se2, pwm0, audio_pri_mclk_out3, audio_pri_mclk_in3, _, qrng_rosc1, qdss_tracedata_a, _),
+	PINGROUP(14, pon_tx_burst, qup_se0, _, qrng_rosc2, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(15, pon_tx, qup_se0, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(16, pon_tx_sd, audio_sec_mclk_out1, audio_sec_mclk_in1, qdss_cti_trig_out_b0, _, _, _, _, _),
+	PINGROUP(17, pon_tx_fault, audio_sec_mclk_out0, audio_sec_mclk_in0, _, _, _, _, _, _),
+	PINGROUP(18, pps, pll_test, _, _, _, _, _, _, _),
+	PINGROUP(19, mux_tod_out, audio_pri_mclk_out1, audio_pri_mclk_in1, _, _, _, _, _, _),
+	PINGROUP(20, qup_se2, mdc_slv1, tsens_max, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(21, qup_se2, mdio_slv1, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(22, core_voltage_0, qup_se3, pwm3, _, _, _, _, _, _),
+	PINGROUP(23, led0, qup_se3, dbg_out_clk, qdss_traceclk_a, _, _, _, _, _),
+	PINGROUP(24, _, _, _, _, _, _, _, _, _),
+	PINGROUP(25, _, _, _, _, _, _, _, _, _),
+	PINGROUP(26, mdc_mst, led2, _, qdss_tracectl_a, _, _, _, _, _),
+	PINGROUP(27, mdio_mst, led1, _, _, _, _, _, _, _),
+	PINGROUP(28, pcie1_clk_req_n, qup_se1, _, _, qdss_cti_trig_out_a0, _, _, _, _),
+	PINGROUP(29, _, _, _, _, _, _, _, _, _),
+	PINGROUP(30, pcie1_wake, qup_se1, _, _, qdss_cti_trig_in_a0, _, _, _, _),
+	PINGROUP(31, pcie0_clk_req_n, mdc_slv0, _, qdss_cti_trig_out_a1, _, _, _, _, _),
+	PINGROUP(32, _, _, _, _, _, _, _, _, _),
+	PINGROUP(33, pcie0_wake, mdio_slv0, qdss_cti_trig_in_a1, _, _, _, _, _, _),
+	PINGROUP(34, audio_pri, atest_char_status0, qdss_cti_trig_in_b0, _, _, _, _, _, _),
+	PINGROUP(35, audio_pri, rx_los2, atest_char_status1, qdss_cti_trig_out_b1, _, _, _, _, _),
+	PINGROUP(36, audio_pri, _, rx_los1, atest_char_status2, _, _, _, _, _),
+	PINGROUP(37, audio_pri, rx_los0, atest_char_status3, _, qdss_cti_trig_in_b1, _, _, _, _),
+	PINGROUP(38, qup_se1, led2, gcc_plltest_bypassnl, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(39, qup_se1, led1, led0, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(40, qup_se4, rx_los2, audio_sec, gcc_plltest_resetn, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(41, qup_se4, rx_los1, audio_sec, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(42, qup_se4, rx_los0, audio_sec, atest_tic_en, _, _, _, _, _),
+	PINGROUP(43, qup_se4, audio_sec, _, _, _, _, _, _, _),
+	PINGROUP(44, resout, _, _, _, _, _, _, _, _),
+	PINGROUP(45, pon_mux_sel, _, _, _, _, _, _, _, _),
+	PINGROUP(46, dg_out, atest_char_start, _, _, _, _, _, _, _),
+	PINGROUP(47, gpn_rx_los, mdc_slv2, qup_se5, _, _, _, _, _, _),
+	PINGROUP(48, pon_rx, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(49, gpn_tx_fault, mdio_slv2, qup_se5, audio_sec_mclk_out2, audio_sec_mclk_in2, _, _, _, _),
+	PINGROUP(50, gpn_tx_sd, qup_se5, audio_sec_mclk_out3, audio_sec_mclk_in3, _, _, _, _, _),
+	PINGROUP(51, gpn_tx_burst, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(52, qup_se2, qup_se5, qup_se4, qup_se5_l1, _, _, _, _, _),
+	PINGROUP(53, qup_se2, qup_se4, qup_se5_l1, _, _, _, _, _, _),
+};
+
+static const char *ipq5210_get_function_name(struct udevice *dev, uint selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq5210_get_pin_name(struct udevice *dev, uint selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq5210_get_function_mux(unsigned int pin, uint selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq5210_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq5210_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54, /* There are no special pins */
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq5210_get_function_name,
+	.get_function_mux = ipq5210_get_function_mux,
+	.get_pin_name = ipq5210_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq5210-tlmm", .data = (ulong)&ipq5210_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq5210) = {
+	.name		= "pinctrl_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A438FCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6674C6069D;
	Mon, 12 Oct 2026 05:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_SWAUO32azF; Mon, 12 Oct 2026 05:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B50CF606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781723;
	b=J1vV7zgBv69eqgnrsfoNID1dkXnOdyaetxAImrKeiqxFfrSQFndYEu3XB3de1SOOH9Qj
	 l+umk3+oNRFOSzD742ROZIGS3mcXBDXNE1xh3cIGixkq1svgOt5YMFUKJH/d+FO71yOyy
	 1ffa2HRiJe/wwHeOz0oB+gWbz1E2M54ZGJK5bNwKFdEuPclG5vNXSBguM8ZWxvu+rdRh8
	 mz4AbmIo9VRWCSfa2ThR9lXln0fQUAJbqz9cfBqbasLA5VnMiOxLlZY0XUu7f8NUuAfrV
	 uRYMtOHJFX/FOx8EmkRFfZyabj6HnJejlpdU0uLq/lcwWJKgBaQLTBogPcL1BT0C2ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	b=K8vdiCZosOe9KUI0n9Ka6MBB5vSXyx+l34SayZLR7hUSE2HcCOZENucskYYU3UpID7gH
	 fFIaCGSQbQe71Bv9KYXzD9sIiVK/kq31dgpm+PBPGIlGmESvdE6h/DihUYZ6ZJi4kjSI1
	 9lTOojh2NqFupJi7TUhosVN3++C0SgNu7FVuV3ylLc4gJx1TLjROPR4lmSUeLiLHSpTBo
	 6c+Cunscrt2cFPWBv9Gf960HPGdZzDZQGyP+0gbPAzhh6/01KuxdF26V3vjN0+s9WcLmT
	 XkFZBneFHaxHzTiwdk25dBMys7Y2T5VlM7OtZh/OjW58jTHK/KJhfkxhxbtQD2praAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781723;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAcxfa/OpPGGHjQMbBvXaE7XnwnGsqjCm3qKgINm7Z+W4OxxGTOlhRrlUpCqOIse6
	 5BKSfj2MGpgVr4bW7aPHFAyyjzvbzTk38AXfYSR/gQhYj8u2+5dYlWh7Dfjbq6A71e
	 Ruiryzo9BsszZox3o1tt2GmnrHmBj3L5XM/uydyggis0LTXF0BDS7OjTrjr2ESbmtL
	 mqGc6hAhkEOeLQHROlXPLT52kqnf/++OlgUreGWtPEUh+Y0x4ll0VwlVnagsLXQO7r
	 hLkCTHg1GIudgByKG00jmAv2BADN+OUtKLvcm2f0n/fT8ie4cYCC72qa3Q7VVl23lw
	 olx4PX68LJC1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B50CF606A2;
	Mon, 12 Oct 2026 05:08:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E67DA58
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1088F4056A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zG9oKTD7GqUs for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71F3D4055A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781720;
 b=jOxub3vh8SvPKNiuSAkTFlXIYEe79apdJGgu7PW+/orMoWcUrypaGFQw19g/wTgBlzJg
 3mu+DU0gvwCwF4/FXzqlLq7PT7fR4UFTOyS6yuB7sJluCxqkpy4eyjPkvieCvD0xRYegE
 Tee92pj7r7EykRSz0IIimaZeHcGXxwimgWPXfO3xonC8ZKsOKg/d1nKoJixu4YFpo5RoJ
 NWFvnYYMxlVtLSE0d8wM6Cze94rZh4Civ9a1E01hBYXGvi8FiNPe+y0XhH89tozbp3mAq
 LwgoMGywPYvejleH8/TTD768HyppCFUwc8qBH3m6Em6tKKlugGJYLsQlOL5n/B5PGXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781720;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=pLSJKzEDSSbrFMWFsFEPwRhtDHgClBFwvTd02FkTuZ2AGEMI528GUJZWENCLydGOQWt8
 OxNRIWssv2dWzwW5bkXxm9s04Sp50pAQ9JyG5TpTvxpzb8g+650cCrY/n13PiDeUURiG7
 XIN8J7cghD/RZ1/1/H2KXNjbxCe4q6VBo6saggQ5sM7rGH07ZPguCyivazR5ID1dkh99o
 qds/U+lrBvROl0VMu363EFlHbyuV47W0FvrcN9H4n+DDKCVseZFz70a1StiClSI8CC6Qn
 WiMpBKNEK3lliD7QieQ7AHi4a8T1O4kkErhYaPERROhMW+SDCcMIuSjVE4QxLBKS+nw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pnuQY43u; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WaYPUdPe; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pnuQY43u; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WaYPUdPe
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71F3D4055A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C56CRu1340469
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ErfdW+jlRb
 IWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=; b=pnuQY43uqIXH0NYh4jHvsKCFufv
 DDhqvCpA2CeChcfvrfYGRvszwcjsHiwsN7tUzdyi17IsGaCs9wyG7Ja+7wASlf4U
 xgQVzy0mGwRHBJuXdrQ2Jk8d3DTdbBWHPgZa8jXueZpnfIq/phVu4TmLRaVYjJ5M
 0FsFekgt/THFiHWL22bV4GIVXM7D615hZHCbgEowLnRsa1Dn6fvXgU3K8iVqOJod
 63NqQqDxZrRM4JZslVxyhCcUOic5VA3S51+hyFUkEt8mcn0K7qzJS5d2scbpjKNb
 jbnMo5gMhKVPmln2mSf934MeJXok7mP4gzPwrgvPTjELMEiDnntVrztNbng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24s7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so4808381eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781719; x=1792386519;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=WaYPUdPeVmWfUTMvjRhdYkmaNswEtV8yunbDV+n39iI/ItwVKS3ftQ83pQ9OG4guoM
 ClX3dMimyzF+B9e+AvH/7I26ndm7iWXVddo2FLi1MnClXOiQNPNW/P79BCz5tPk8qJ3E
 +4x6n2TB5SyV38yu9zPRtlglSxQxxcttYQ8h6YA6Iq9xEcGHhPKazESjlfR7xjIyVI1q
 KNlppPRDWpra+f1IWirxxLwGklJr/GGSUAKcHMUjqAokOx8WPcnQkcCSALEvDHn+tf2i
 vkaVVvLnRVIEDR2TXUZ771q+7A94S899/kr9FP/qr9vv2xYO7vf2N74YUz0ezid0GGYL
 LDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781719; x=1792386519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=JfI08cVa6hEKcW7ZPKvzcfzf7NxFNpiEIbo9VSvXCkJKegSiDKBTlh9sWoL5bi+0cr
 bkHWxXXU2Gs1cpAcHNHk4jNP1RqBDlqB1FCGFMJjLlEtKJQsRd0slEkwoMAP4xDjUdZk
 oGWrfpN23NasY0UwZbZt1euXs0aC7TOdXSOS/YzD+cuDvV+82ouwBW1OoyK4HrZXaHT4
 XLbrUzxKyumAEaWyDlXM+8sd3tH0KJS12wsW3Uhbd+V7JrWn7ulhzsSw63Shs1b29X9T
 957PeYfb3/WkEzE796FuhOBmUsPnXj/W/SFhXrOVm60hUB/8p+5JQ/9EoEFRWecRv4Ap
 rPNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpCqTPa10mnih4W5NS55ByQwYNuErg4vcUqlwybTc7kdFjNLCvC8eeMg0QE48tqzVP5DtjFRY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIr3M4600Mhde2q5TUa/EBdInjXBnjdKBniXEdY6np9ZRV+3lDO
 WajIxvmzEQHOxWXl/ZmOmK0kLvU8inrxOBM5/Y83G7Jz3oErBccOCtwWVXxVnW2I4G1aGrxDz4V
 YJKc5/ox+9aH0KbAEsNCvww+LUE6S0juBpUdV2NdIuX2IB3D3Jdc2JYr3n0kZEqCav7NP+m4=
X-Gm-Gg: AYBFou2qEVj+9INPbPTZHvUcUUSeMwyqRCBRcDxbf24AbqSX4+E4Mcmu7rzC8q1i6Ha
 5GanaR88yhdprKrlPtEVy+4W3/0JkxzD7rw7xHl3hCYPs06Ht2B8Kf/wmDLsfcugVNAkGa9Kim9
 ItTSNwMVVkaKUWddhNfvY9gHAOGh6Ysh/UXxY+RioqKl2a2G/1+09u3Q1w8wjZSrTVVqXrXtC4F
 sCsPuUhWX0uo0vKdqBHUsbXcPFY1TW/NB16fX3fODZ8AoaX/xbyqTUJFLEFgvfOCw34YKpz29i7
 N3V6QYpBZkukLVgV2I1wSfvYfB9hLsx0I0O7AC3+om4zxv5vUEnnP363OZHyQnUNwMo5E/bGN13
 TZiXu1s5gy/F9RCMjDY/2LgyALTqO38ne/4P2Gp+TS/L6ySU=
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr12664719eec.18.1791781718420; 
 Sun, 11 Oct 2026 22:08:38 -0700 (PDT)
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr12664692eec.18.1791781717804; 
 Sun, 11 Oct 2026 22:08:37 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm30362095eec.26.2026.10.11.22.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:08:37 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 1/3] arm: dts: shikra: enable SPL SD card boot
Date: Sun, 11 Oct 2026 22:08:31 -0700
Message-Id: <20261012050833.1554624-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
References: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0NfQldu8zQvtgmcZWak9UYDGQ4sb7zWK
X-Proofpoint-GUID: 0NfQldu8zQvtgmcZWak9UYDGQ4sb7zWK
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc6b57 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kLX-VyqmV7a6tMBdCCUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfXzFaNlEq9yUNY
 lRMZ0f03iJdDMA/sUroD7c31VAVuYt6GpyQhPy5iQfiJuaS8k1zyqxJ3+Jg0nls+Lgf0isLdlqo
 CkgHvU76w/IEBtCeABdwKhVrycjZkd2Bhll6utMPpzixHtE3ysIH7BLaY5Zhmlcvy7gWIR6Z5nd
 /U6e4Wn0F+myHEJCgLoON909bs158h47QUthB826cTSTslyj8e6scfK1C+YX24wtkWATx2VLgbY
 Erh3dUfoLJtOzst5AR7klMnJMaK/+GQT0+GVrpEtxflHG4arzi3ZyBZDL5aUrXyiVWbQi6jWiIY
 HCsRHUgJpd58sMD2nFAc+RMg1tpSim8Q++9NgeUKv+OG7HaIuLRgZho9szLVYXukAn9P+ccBbqa
 gq9ZsgZdDNGEPWRfpntN4z1MEFsGZkEagIh6pWBPnsbVl7zCkDR22/CmnGXeOFdKuNG4wlKPmzt
 R4JI0EXGTD5UTjEojQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfX4J17t5oyKhza
 IEX1mbhyiZ+VVJjZlZQ8KQxXg0gl89gBOHB6Ow8JUDfFZXOeXBKwIMJUhnF5mbETerfgoXFtj7c
 Z2/A/7hWhuRjerZScx58ocW78QrlIFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120020
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable SDHC2 on the CQS EVK and retain its pinctrl
and regulator dependencies in the SPL device tree.

Add the MMC sequence-1 alias and describe the removable
SD slot with its supplies, reset, and 100 MHz limit.

Do not add cd-gpios. SPL selects the boot source from PBL
state and handles the selected SD device in board code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e8831da6aa7..8e2ae723938 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -48,6 +48,25 @@
 	bootph-all;
 };
 
+&sdc2_default {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_sleep {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_card_det_n { bootph-all; };
+&sdhc_2 { bootph-all; };
+&pm4125_l18 { bootph-all; };
+&pm4125_l22 { bootph-all; };
+
 &qupv3_0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/shikra-cqs-evk.dts b/arch/arm/dts/shikra-cqs-evk.dts
index b3f19a64d7a..23f416e6fe1 100644
--- a/arch/arm/dts/shikra-cqs-evk.dts
+++ b/arch/arm/dts/shikra-cqs-evk.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
 		serial0 = &uart0;
 	};
 
@@ -38,3 +39,16 @@
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	resets = <&gcc GCC_SDCC2_BCR>;
+	vmmc-supply = <&pm4125_l22>;
+	vqmmc-supply = <&pm4125_l18>;
+	max-frequency = <100000000>;
+	no-sdio;
+	no-mmc;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
-- 
2.34.1


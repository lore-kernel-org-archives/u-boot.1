Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAE9C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7429360DB2;
	Fri, 25 Sep 2026 14:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiUL6JWozyU3; Fri, 25 Sep 2026 14:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6380D60D68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346407;
	b=UDT0xtAD/2+5+8V/kcYmYM8KXKhovCJytCjKu/8wRUz0Vf7k4OwaYJiJC7CX1TqzjjyR
	 16CkOKmgWWmxkTr4M1aZI/Xunt//rvKPnRFzxFkcub5txuwRGiN2NH8OOxHKn0TNXS2e4
	 4ahODIveD/Eq1HexjkXPS9lLsHGsxvHWBGswqlcKBVqTj7sY9J2NC1Xmq85CARiXbrVsh
	 8brvAbRuOurk4LjklkAl3KgQoHTzgkXmjEjsBQUh5Cu+srXS6AvkNp6Z8snd0PKA4Bhwr
	 4yJ8NdbJHiojRMZxHqYehoVl0U+DgBzgEP8pxXPeaEYoUkg2ep6ZNwO0R2mJBaOeZuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
	b=jXiDHB7MW1PRbXBjEoPynKrgM7cdWJ2C8j+TswIRDzB6+fnPgN0XozqYZt8nJ5nNhJG0
	 aRC+mEnBWOUSeHBKHg8AjYRAK2lk46NhVeTlTW3pgL8zzjDh4rkvEcqubCSpnz78IYXk7
	 9oCGVsxNBeilOoM2lGoVTbpxquZiy5XKC/WmIx83SFT1EgAcvY0rNzlawm+v5fytO0tI9
	 tXzyXmPKskw2EGwdDbcC4OjFiUniCPn5gQuvobqON+1s4YTZMAniV/3YgxG5aTxAYJPal
	 lkKqsACS/ti0L3rtoUTmgAqsWVb8tg2QT3G8OqDbfjlhlY5j9Vc7RxPWd0jxM7aacmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346407;
	bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z2qWYK453/ZavJiDPo9eJSmS0xuRasOwJq46BeXUZteAIBiKHTxk4ApBP3XCR/1xj
	 xApfdrVMzidgY3DFkKlS9qKvtV1NoSFQTp+x0mcoS+Mt2nSZMjxxnDG0ZWmIbglhml
	 YvhR3IZv3QJyJbOxdRX/Fr+yszzB+QkSp758x63MAs6Mvg5FjlbhbfS1K056c50Uqg
	 FyJo7gKHiJnlRn88mcxRpKAZFrxrVIksWyaw/8ScwII621wRKeC7LUDiWlLieVjAde
	 XoMFgShF19sKJcCcb0EJDOrzmeQqU5lU6XiVWUBuRBX/kFkP/9CV2K7tq1DTvhaT5u
	 w3t7tCWDcz48g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6380D60D68;
	Fri, 25 Sep 2026 14:26:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7036F355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DD5D40180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2PUThbTerRbL for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C73AE40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343500;
 b=bb9J/QNn6WMctkFJ+W70smP93g6yZpeUhZG6Dr6in6rpxAuM+EPcmVam0ueHuqtqsMPw
 fOo3A8dyRusCgeqabwWd3nJEGXNdTz51D0cgLuf6zWh00o6TTew9xyv2K6sQ6XBHAN7iR
 R9EcFIzAaFbR+DqhSYV0Npp0eufb3s4niBCj7uqMMbwvbE8kHEvgbjWaAeA3Ip86c5IFP
 WvKLOTyXIF1aAw8WvM8j/J+E3qWhPJ5ovYaPcqRTnMu4ghXRGc/t9gyA4TCXc26H4dsWL
 HB8ANIGiSg5UaJwZbCq1NdsMipctAt9fqnZj1BuZh4JNaNdEceDMvoq7yHv0S9NXW6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343500;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=MEreyTd+kK3Ong8vQZwV55PcxwDmn84YYOLxmnozEMr1hKp1ciipmTc4BFW0M0+KuYX5
 KOUxypNorZB3voHUs1KO8aYHJbt8e3vWQ/s1nK2B9IfCBMVpJFyBiBHw9Tlc/3HFt4F/U
 o6GQB/fjXud4l8gpb313k9FvR2CpchmINvrAaCkKWx9OgJ7aA36eTYNLoRr0w5MKxtajr
 HZiXxwsr5a7XLkCJXrjThv8DQkiIyTCETZsOykQJ96uJIYmbS7FJEtPv+9SzwMsScZaEQ
 m/ll9YFl7p9Cfa/rmC/ciTt8HLoFNh5i1s7WgfUenzmD3dt6ND0UN3hW/imb0Whhd9A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=P1aAaC1n; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IlsM5pde; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1aAaC1n; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IlsM5pde
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C73AE40042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCZCVT1055388
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bsGZ8sqTA6p
 9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=; b=P1aAaC1nuxzB01kTRaB9SFAjbC8
 PoA1Q0pdnl7dtwkNh/Jlk0Fak8bgXyNbxAd+/Rm/wgb2wVlzA2koLZpWeSZMM0o1
 Situ3kRAoy6lK3rVsqwYh1oCzOAhBso86080n1XIuD7VU+zAkGoRf//pi6OW7PWY
 +VD7pxWvBTjfYMHv7JEj8rhUtBEuRsVW+TnKR4gbjxmqt3PmFwpdm4/ib2kUrjdH
 w5S+12QBmxUE5Cpa359abKZsH4HQ/b+OsPaJnh2RiI+DYvVHfQnSOFtZidMiivJE
 +RID3OtnjEkKVPo2JJ1WS45XWcXs+CDj7uxBJF9Sgj92NTx46/Cz+8nWZ6w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7akv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so991453c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343499; x=1790948299;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=IlsM5pdeqq4GMvV7DYND2Nm/r6l27CarUZmhR4GeRTiSXNCYFOstH/a6ha2S+0Tu61
 0u+NbcdYjD7tc0nvl6C6BTi376D7BhEXEDZL+n8nxJMchkIaOKBXl6WkJeRQTMSO/dVd
 RuIDwWKognH/ofMLNRr1knmk8LUJ78GTqem6yddSS0GLPWQWOFz1fV6fbf74GOO/Gu5J
 N5WKhnSx2f0rffdmKJexXafq72dLBeV9jLV85wt/s3HcT9Pll7/r8t+4FdF64POLZoE4
 sCV2PFLDv6WiBUzLWRor0jU321zZ/C73jyQI9Sfm4bu81GtI/accF+lz9kxZGyHIgMbO
 kjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343499; x=1790948299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=H9YxOcJVkB3K6Glxi20JVTpTQ02/vxFGSYlzm/+kJLUHoVZz7oby5t6IDCdKrtyEWM
 VUh8lIdC5e20xe3uYfmyY+dUGTNC5ire03v+EjbF2bTd+tqaIqzD+rQ7dTg8UCZLx6ES
 3zq1cUPkDAVgUrPh3opGfLz/FJt5T4tTcX6iqBGcfMwF156QWiOT3nEuHMoBRaPOBrzx
 +M6eeBgeaZ7SSK72BONVYH2CKp/ESIjM1FsuQUbM5ATCZM7/tAApUZhPnpQCad66xnb5
 fzOndVOGk4I8B3lgU3dtBwlBmyZ+adj6XijBo+3eHcHVly3FspiN3/KNI4a+WblzmvnF
 LcKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydeO2mmYbt9aOIKlOB+T5sapltk4h9mt7SV//Apenu/jYYikKHwMOgWMDmNTd053cI6F/8epQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mVpJvo2tU0K9XiC8SOwuTIf9BvQsQvca/TpWA2T9JaqFGd28s/
 CdoLxDqaQeBsyeT98V0g9DmoJs+wrOAN18XU1HykndkG+sOTPnhBTM53klcRAaJChvnzKtsPaDt
 KOhM6z4I/ln7oK1RBsyf8aEXewzEf4qgIayQ9xyRW4+ggbz8Fumgq9H01byZPr4Jyuef/paI=
X-Gm-Gg: AYBFou3rHeB8bV0ZQHa7dvfbKfs8WBVyK8nOBL3U//GzFr5UG1bsJ+nyoMRn9pj3cmX
 kGBFJE66oqH1lpgUsjX8tCXluuW4bod2iqUaOAp6f/+c+lSvCJvspF6HlmzhaidcIOEBtG65dir
 916U6Eq8yegcckpxZfEaNhobng7QpGUzAhVRMGKQPTgPHlJv8mZKt+O9hK4oTkjAqbfwNpUG88L
 XFOftA+fLSIvmE+PDDe3sm90FsgPCndZViC/B0hodN1B/rXb1xtB//o9/0yVO/pE43HyD74Acqt
 BAzMxllR/0g45KBDuS92IU4n81K0j4V/Afp60LJCrX1SonJjyPAnDrlquxaihrFJpEMt1FtH2x6
 EVelyjtngOdLQzlQkdPXe7wEj7HpH7UKHGQiCCkHunT15gFU=
X-Received: by 2002:a05:7022:6611:b0:144:fa57:c617 with SMTP id
 a92af1059eb24-146d039e8ebmr369483c88.34.1790343499117; 
 Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
X-Received: by 2002:a05:7022:6611:b0:144:fa57:c617 with SMTP id
 a92af1059eb24-146d039e8ebmr369415c88.34.1790343498191; 
 Fri, 25 Sep 2026 06:38:18 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:17 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 09/12] mmc: msm_sdhci: make tuning callbacks optional
Date: Fri, 25 Sep 2026 06:38:03 -0700
Message-Id: <20260925133806.1403713-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kE4q29vho2AkIjdzGjKVKgHvv4ExrHW9
X-Proofpoint-ORIG-GUID: kE4q29vho2AkIjdzGjKVKgHvv4ExrHW9
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6794b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=AWXtbog4CBKr6sa7RggA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXwvfIYBfAYKxI
 8cjNEEY7kAme/jm+bE1i6Qylrb+xX+q1+nVYbN4BoexgP9EC9RzwBR390zu3hPqvfGk+GZqhuIE
 6uyCrTk1LGDxCBhtcOZlugmHeNOf0YnP34YkncQ0pmVhFeRTU99QZGSusChlPgJFRJtub2Qjhib
 q/3h/3aL90MrDVH9skWKbm6MCIOd9gkjx05GuEI9PEfb1bh1SFoUdWN2RTDHdmn+ATKcSdD944Q
 7gzr90SzcHkmsMBAj2i1A9QN61/8X0XkBdUSyZQlJRIqNrMpYIQmang6WjlkGaG8X28xop+BYCr
 70E9znaJ2utBxBmL8UStSZr8WsIPZ2WiNqLo89PQTcgSL6TvliMWKVX2Djvnb2wtkEFKuula+18
 4GWkyT2+ivlMmodZVqJllrrNr7w3gzakZ+fh7KGBjuEcAWuzxykkPANI8PQGCJvW89zIRhdTtL2
 VWAh2aVJk5yFk9OnvTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX4UyPyTk+mAar
 ntD1UURfnk4xu0tpnx4DuCYZwNuuq31Dr7M3NJMCK7GWTLZ4dsbzOPTWMJ68BBbrpCw2F15XNDG
 JOgnZpoUFHTrLXBRzYe3gHRpgMiPAW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 71a5aa15958..155bc2ef379 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1


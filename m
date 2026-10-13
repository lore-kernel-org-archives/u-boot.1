Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C28CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE1DA60752;
	Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9YJigx4SH5YI; Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBCAE6074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869590;
	b=rZNrr/UrVV3uTUUAXLBi+Ckcw4Nv11PpzuJhWa3G8GikupPVh8AhNsyLt2HoeWhssyp+
	 xk/DqqZcLIV3e8N3ZrNGBUc9rSHRF28qnvno3yIMOD6K1bCxFBSuXNFMd5rImO0sE1WCv
	 scLpahqzMVGajj//3QzCkZrM/00UbqlUzqUxmnaZT6Nit9B/fIV5RQHGinwuUThl7uHZl
	 vUsCyr0jWqFer2HZ6M3w29yqgAUiQyWsCZ7QWTz9mw1CCTMFy8Xdvjsdd79RD9c9ejPqa
	 WnoKZQI8cigs1vOOZYQMVkEzXORzgzo7vgxmbioTg/IQiMOGOU7LNSobwH7wPNdUWig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
	b=T1pTufgWKtOCiu3+gU5hPSpsfHmcsJu6moCfCzPlswNiCR6TRcGORrt/uNMqrC6Hdhxw
	 VKKjVyGx84ZNRZ4xm/lrgjJ1hT/txUBhVFyqLs0gkwFSv3ESwvOE5UnCwJhDlHIxuIvQE
	 /TUiQii1+nSe6xCME9/C6YiwIHwcRGhn4d744QD9fUmcLJ7lZ9mdDFgZ2bVmPw38avFgy
	 POmqn9KuzXLVhTRXMN4yl7qVyd5wHVsPA8/hJS3z6hwqVZ4aiIwP7P5YHbh7fYfVMWkbB
	 BNmyiL3KebBSJvMaMuv1kIuex/z6Mn0MaFPV/eE1jF2Ogm3k8YMwsOSDX8XynIJH5Fg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869590;
	bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mszK7TfUA6AIjAh/i4hREhVj42CyT/7f0XnM50ud19/rkFGxKpR+u23FDvBjH90+V
	 Li0gVq3d0KJ+7OOOBgV92wYJzwEh4O/9+ukuMUEt+E4kSTyQtYIC2l9pVRckhi9e3Z
	 0vvg8AiDhKfD5Xs5/y/YIC+ylHoFAGMjBBwaKd6tt5ONXq5I/uozbaGmgfkBsNbGY7
	 S0DBDrgFxxloFj+QUMhIJYubgLUoP8H5luLsOBoazs6IlvGdyKgxsaY7FCT/TX1mPg
	 JDro2dlVfJasjT+r8jbzLDaKHY9tAdGTLsoaz3I3yBE1pebYGX0QGVmd26xs3irKla
	 mTNyIKLkWVUlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBCAE6074D;
	Tue, 13 Oct 2026 05:33:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8FF1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CC1540619
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YN-rSiftGjz6 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C41240609
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869585;
 b=pAgTgVIQLLr+1XXUf3vwRLJlfjy4KEWpIUw+7V7t9z0UcqBFrwiO04EtngPaIxCe5PSf
 zPI91grjbSucHDvEtB364QQxUsJm586S47lrg8Sgy24Jti1JNgcRHTNtxJL9YCxD8TuJD
 9DKwlL6OjagPTZS+Gbu8ct/8ot9EAfd93CPdWNhmYsvDqgOvQr21/gk/Vjk7aTnhZaST0
 evLS+gjJ39buNih2QRdb5jPj/fCjW+HeYWfpbY+/J0q8vWFtG0fnx8aW93ragA/MN6FSn
 JmicdkwTSpe+pcpsS8LfBhJMtjGSb/FYf2NBUfhY+PleG/z+rl6JzHAn1n90B9579UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869585;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=AJmRGcCSiZ9UpIjuxnKJ9jHFtObi4cAHqfrRhx19wn+xFAawvOvPp+C2U2F0SER0KuJH
 80Enf8BoIaSsJnSPGgIoC3u9eB/+EKBI261ZinNqtfo3uk2Rw/6fFJrCAEwds7xjQMBnK
 CW1SL5lzSMctjbg8WKIcK7LDJJhvNwSXFZQlc4uDtQsdNiaeR/OsYhRpDs41+4vxfBHau
 RAC/vN+4Bf47iihklvyEc37bPZ6EB8+OqF9FKXrTWoCXadE0N8dyMX2HnfHegXDzhT1Va
 sEQn7q2pD7vXczrZPIoL7GGiHttBhnfmv/XxhuCQrzuq49E/P5aLW2MLq1fSSKZsKlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ad1Let7x; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HBjlhKbF; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ad1Let7x; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HBjlhKbF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C41240609
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D215QS408880
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JgRvNlIqWWQ
 EzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=; b=ad1Let7xwjTkAm+pcXBu6CB46P/
 VEZMictIrxeXasRmo4/NpiTlVEKMeJNKCFEdKkPaCfTC01ydZwyB6WYR8bLcm3iP
 yWoWUAQh73tAl+os1xgJdZ/sGQLaeg3w3rVEp1+7ZGWB0Zd+/w7i5LfHx/M0h0Ii
 EiDmC4fjpK9wAZVl7nmXc0oEGkWAT8u02/P0ruRXvqgacdIsP2RV/mIoTaaiw6s5
 UbpKSxO/J1hvw37A2Zhh7yyctjhJyT+OQ5xp1Ma6R7Fqv7fRx76Z51NkX7I8tC0N
 97gXn/69cIkcC1qzKDoDJ216hkBnAUg+LfJqF4a9qk6iqpz+TpiUwTAm7oQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmakj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so2296972eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869583; x=1792474383;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=HBjlhKbFe+IFg++Az/qa+E3sCAHUnMDlZdF5xOdeQLgEcs8p84rjquhgoXK91Xtnac
 Y6/nXkXbVJupHXR3baKrqvDmxnxlmWBuSzWylhnxeciPLXCWTH1aNsPNrngf0OOQmpdq
 mcrBbWWCDi8PkX+vl4mrCBH9eJwnxHRsY5rMoAyRTTki2/5gOFFWZefxdtDFro6YJzaA
 kHoKLSaEzo20qXc8hsuWQ+/M7ysoKo6m4IluU72JDcvHQH6eMIH1Tyq02qwiQjbs98dN
 Hsf/q+5JtweJNxm2BJXx8jtVZgVb8hto6jZUB4JKaiu1+4Kzpt8YGBRiELrH7C+ssE+g
 3kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869583; x=1792474383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=Wzg0QexpIJu7YYznFuwKM43Ve12rSwAfpHoDyxzs418mAd9ewUgG6xlDMKv/gr5GAj
 n6aZFmkFfKGzmoqB4zNrdx2OY3gR1KAgXB2JFHtF0tGB6LDGAikLc06arJTyHjEjes2k
 uhtapf3Ewd69ElPO1BY8arinAjYpvJQLc2Tr9ygOsbhle0SGsX2a71OIBYLn7gAY+2oW
 zgwLx1KZbmkTL+JPLk1OLW97yK1BNByiUzDsrOqcF75LFhsyJ60qVPvWN9xcesp525rV
 BoSzhT+/hx827ssTHZ8C9ms4PCD8a97nMbENXvyEZspLXmwr250bLTzqe9eh+DZuYmu/
 cF6g==
X-Forwarded-Encrypted: i=1;
 AKwUvByNJWNYjVWlfs4Ae2uPrIWmML5OHtgLVccbyayLqBKN7aqV1LkbAJkIETWqYGbDiFtuQ8s3sOc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOXOA6UJL6b3ts3xo9fVyiCHhXkuGz+VCwKAHN8qzv1bHZpCVK
 af/mPa1T6MnqznVOfyOG2E7EWjfUXwRuCcOARFNcujtp+8DP29Kvhv6GvgsyCSiHfzp6FNcV4Rm
 rk45Q4MRInCjj88ylqHCSoc1ASH9oWSBG8COMOnOjgAt1czHjuwNo5NaIIeQW3YFQlRzumJE=
X-Gm-Gg: AYBFou1oZHiOnz2o+qDrWQYwp3G7NStTsElgDvHZs8tyc9NItKrQq9VLumU/YTWA9QG
 3qO5+Jj5uAiPQPofxhDPivF1FHvWQTHsGb1P0msdefgoWLFLSSMu2m2fYI+deJs2Go5AVQmCerU
 Udl12LmiErJEL5DjM7DIfaY78nvQkZX4pr3o14KkK6osStLFA0WsNpfQ+LtyZUMhRaGcp3pRnZI
 9EJwj4T9xqcYmIOMDCwjpmmhXL9mzX5j02nx5tTdHQ0Kt+xw2iOYknMYziDuxQXea2BxEmAExD9
 nE0UTHz0wz8m1+YKwV96x3xqOUblSoXDxJHWNdtxsDkR6OTjZhPHFo6R9i6hmhnXiqvt7OChtTF
 gU1Dz0kDbeaasIZH7NA1m8WO5BusJYuQtvJYTMcy2FxwMkto=
X-Received: by 2002:a05:693c:83da:10b0:353:804a:5e83 with SMTP id
 5a478bee46e88-353804a5fe8mr15721012eec.8.1791869582625; 
 Mon, 12 Oct 2026 22:33:02 -0700 (PDT)
X-Received: by 2002:a05:693c:83da:10b0:353:804a:5e83 with SMTP id
 5a478bee46e88-353804a5fe8mr15720987eec.8.1791869582054; 
 Mon, 12 Oct 2026 22:33:02 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:01 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 05/13] arm: dts: shikra: retain QUP SPL dependencies
Date: Mon, 12 Oct 2026 22:32:36 -0700
Message-Id: <20261013053244.2954876-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXwCSJhrlzKmNy
 HZ+60450aNqQfMOOt4TieH7Ad/MyvTELxaMeSNcxDT1hINzzTz+Zb7G7bnZ6YKWEuSzzs5lXlh6
 xzwm3QDhMBM0pB/MZ8D9GjppuG13BRyZJF6Zj2mr6uC+zUkhsKImdp/F0GcFCnDT8u0bYxnCBA9
 9nbR4hg9U46HhH44b6Su9zuXsOvyVSeSYEZrKsUXXsFGBK1t5iYcASB7wtn1cskd7UJ65bVfL2u
 EcTd6Q9fp8XfGnoD6isg8q5ne2wxm4S89wyO9ogJOD2OEpGAvlKuFz+xTBJXyzD+lpgt+OooWt4
 mpT8Hq+PbX6IsKssHFpM83vLKkTKwZ6tq4vgUrYdmK6ONwRemh9Wd1EGCqU22YQDj6RvlqOuhmf
 7EZKSvHWciEL8Or872JBCXM1JS76U8zjtnFBsmOrS3ZeryxUBPRlbWmtphis6I+PLnThprN1Frd
 Xv2rrQCDIsMiAmV3/Lg==
X-Proofpoint-GUID: X8RW_ek23Fx42JZmW8u6QorHK4SbB4yy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX3Tznincagr2g
 cq3GSsp2kOPUQrDlgIt4xggEW4Tt3ntvoaJuR/ST0f/+P64XgnfSgq8i3KzpPgR8010mxDtliUL
 qwNUYDQaEZTQNyYEHZcrOHVPazXg9Mo=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc28f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mHJ2qds8thx7DnZp6SoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: X8RW_ek23Fx42JZmW8u6QorHK4SbB4yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Retain QUP, console, pinctrl, clock, power-domain, RPM,
and MMC dependencies in the SPL device tree so the firmware
loader can use the boot medium once probed in SPL.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e807b91ef1f..c79c63ad732 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -20,3 +20,47 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/*
+ * Keep SPL console and QUP dependencies.
+ */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1


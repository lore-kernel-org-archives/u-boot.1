Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF3C982DF
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363EF60F01;
	Fri, 18 Sep 2026 20:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZXCez4F0xsv; Fri, 18 Sep 2026 20:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D5B4C60EF9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762028;
	b=gs3OfwqwAnPNO8D1IFSSthwbvIIlCCos3S1PJhGOaPbHO/grwhFpjM41wdv/0L6YLcET
	 YcgHibPpd+bq4K9UlVXdI7/mN/P52FE1HFmPA0AO0Y6iw1foNdd2w0Iv8x9b+ehDa2FAB
	 iQZoEy7IjqO8VIBQNoRvlugkBP4+GzuQsWnfyNAe2P1cqixGTBDBqJJZYPDtJRU1nOBUD
	 sfodt4+ptpJC//sOoq1+C29Yv2P1saoySMcvkkdMJutotiFrun+8JXW2uuoTEUjGY7csH
	 HiqSCOk67rTA+sHJdZcjVeeKbhq8GNAhuMfQO3UZMLCPdmebv8CJPll5RUvFkPlVGkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zR3I14j71t6x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=;
	b=pOZcVFbrz53wcOrVXdfgTcRxemoodKH1Jp0Y552LMqz4iu6wp9xtM35J6jDnHt0PY2rN
	 MHmL+bqQDQTJ1IQP5xe0ZyZt8E9t07jPVg+P87PuyG2sOhFQq/poofJJRIMKoTJJKfno4
	 aKYSD5YHxyL6WyVvPUF41Bxc9W6R0AFKIDkXtea6swCi9X5kuOAuzrZWYGg5NBIKFoAC/
	 z/zLidXZ8aSNYUs9ViDzNY0H4slnIRNDVpPB5Hxf3qWpOGQm+RlD7xUv9L+BE79AYWBiO
	 zqk2+NcxN5cE8nkrv/jOHSTl01vOQu6LFbI6SidIGxaLs53dDeaxIdHmuWFo+pJNrxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762028;
	bh=zR3I14j71t6x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umYvUOpYA6ie+h2KLXfnBeyTu/2CNIkwxKTR70eflMOK/Mx8lHMFnNDctbXIZVkqD
	 CAOfeTiKlRzZPDDPA+WZcfb475/z4sJfoorWEObyDhpMqua53VTCCgExYq5ve5lH7N
	 c+7L5HX3uBUWBvUiVN96f4cUqOO5XyIFOrI0xLO+6iwin5yE3ZUKobdhL9VNkyG6km
	 eUYro0Ogo9GbjARihFPIhVkvgYrGBb81rBf877gLIXffO9u05K8lqPn7lCL7uQcvh+
	 Zouc3D4VJuv+N/C57SEddj2uoitq0sbmjqe47Hm5BJddvv+d7vdzaaDKyPfvRX4B4K
	 FmH836W073wBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5B4C60EF9;
	Fri, 18 Sep 2026 20:07:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC0DC13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD77081344
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2CN8JmlFQsm for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B7A781301
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762017;
 b=X7UCbJljW3BRnonYe2CxVQ6JqsJtGfDYFEWUG+lJLtYN1lMDOmX4fYLx2Ch8vnSPc381
 4hAHqPFMT6ShC3H1GIbue+S5fGvW9rp8ZBZBxc/svM3cxxqooeWPwxb/q/VsPzDGVTs2c
 5/v2PgfjQg3XVsD3y8RLugjCHMLcDlg+3UsRFOOndgCYY1ht9JQXR6IhRMhlJyVPhk+A6
 NPAsLF8NOPBBZF3EWz99Yx91TA/YjbmLViqZHKIEa7Jm0k1uMYsBIldaEchlX5nxRt3D6
 ZBz4ydLIfke2bZF9CaxWCauD+A/Q+NnM2sF28mm7HyN/rQkiuxAkje3nAjspAmV6KOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762017;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=zR3I14j71t6x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=;
 b=aQCjz/u2qgAPVCLMlGupqymy/V9HnXEdAgSkGjCqkpobeqDooUD6OFCF2Zbz61FK8itr
 Abjt9+lVPfFTcUyp7e+SuChT73t7bvfFsJ0q1rRZeenEk1w9FzLzt1hqiwmiZOC0fH96S
 dtfNktebuzeEhTjTVUgdTmWtksTA47Nq/BXe+uBdsFqEorDIdQFPaMEJ8AjB3LjxoxdfD
 smg0OSJwNumOqfukAqHEjZbHaocV183/vKzbqMcJt+Aheh5GV8/+2MiFVeKHsYnS7OAvd
 FhrOQMhmkca5NnXEJX5QIWhVK46kGpcMKY28XGfRAbxLS+yEoHBTBxE92AqbOzUnLvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VjoFZT5F; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PHwY7hPy; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VjoFZT5F; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PHwY7hPy
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B7A781301
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoFMZ4103586
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zR3I14j71t6
 x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=; b=VjoFZT5FtzqO48QyrENf8c3V414
 bvl5f+mbyf/zck+JYdvJX7/YMgG3+O3OvSi8cSYRwSMoq5/vaYIFJSV/qv4NlKqJ
 lgjRkqL5V8ZAZkWdRD1owRzDx/zX7Moj4Otc0BAQptXUr1+swSBDzpo/viuwt+af
 tZa/UZ7OdTymu5ikq1pqMC7pgQ/bT0xwR2H8Nf87kRFgcStI/2RZtG0te/QszO/b
 JBH+lqMA8t2T7zlttuoRFytqh4lxxZkJPLMw7lh3KJLaCHQFxJQlprj8Kfydw+t2
 nhSfgCSJBrrDuc9api1DIrFVlCxK182yT1QB2pnZJOF5MGB1WaMKjMBmXUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs37djdm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so172837085a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762014; x=1790366814;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zR3I14j71t6x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=;
 b=PHwY7hPyduGZ10h1puRCi8SFdLAb8Mv1u8dczSi0RARgyA2FWXtpqOWpjwge1iDVDV
 ACSrEcZfwPlR57Za33Tn2t6DtPMjUTMy3yxzNfID6jmJ3mGc5JDt4uWGORuG+B4U2xL/
 TbtHh4KfG5CO35eSANao8po93OJgaM8KeVdlebzdPSEsNVFi+PnA1TDSj8vXODUiMfav
 5QMA2mhWRbaCRb77ktmyL55lCp2oF/X9CWF5EaMdtd/jVaMRXw01T/fCjcq0V4WIKNCw
 5PJuiOCu2YOViG70s0J6+e2TBv5LNqKfuOSHrKN0SmYiktZozITgfUCY1c0IlKLRN5oW
 Kgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762014; x=1790366814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zR3I14j71t6x1teHeFxamvOtSjnGPn/TVQO4oH0ku5w=;
 b=oI1HMh1u06gsbiRnZOGbzxLbHIRhVL1RExIl0GmiiLrNDwUlUVhoWUiyWijYzhOUOY
 3QB/G/lNZBezOACc2sBQT7jT+cDglHAIymNcIT7ZHuuVn19pj331dLG60QE8P09szbC8
 n+Qjjy7pGVtRyyp5P3XeQl62+rNfIQ6busnCWT3psvYbhVX1s21WV033dd603dfGli14
 u3dgu4Jf5KJIaGGw92o/XWRtcfwb71KR1sn2NLOIROihvI0Us9Fza2VMvwPDhzyzYxxD
 fpMEEYC+crIWCgFkNMy5hfE8VDcAgTHhkiTVegIzTm1CEXS4yxPKPrB1Lw3DZXxgYviN
 YioA==
X-Gm-Message-State: AFuF++ljPqd2GOH3l9AQD1NAnDofvmhLbF4NN/MiQe0js4H3dWR6wZ1o
 lz7JTZ3tVqbusPRJD33cyuPb/o4TtjpObMHYZE9IC2ngicTFBvH0vTFnNUrKqGHa3vr9kiKnyyr
 dwC+AplHKV+0FcbbCGnpyqn9UAhPPeiogsaEeIySreiTVKqvaoDvv+WKb0X2udmlTvD60lvo=
X-Gm-Gg: AYBFou3WCh+cR206QsLgKnfGBw8fT6LPN8wT3ahhQYif3QY0+/bk9EaswPKUGbiNZfS
 ila3FTAGGOcvKUx9gHc+9vgXxjDDb0r1VgHsYEDxSAaG9mbyb/aKcUjNKgqdjmrMo6FKK/1/m5R
 A3hYC6mH+kSfttJQoMsLuUdz4Gm5taDgXIkdXvQwfxkefGzmZvKOxPoc2ARteu50cmRiJwUBqal
 74OHtUQNpDx6DBdML2eieiPc1heyYi3gSidTRK+RH92k07AXzUfwCN7dpNKPByGlZtRKC319Rit
 r6bwfiYvIQU8/13idFzwZHUTeOwqOcg2IASjcqizEukP/MIECoUT8NHHm/b0hiBxGkGvRntGwJU
 Uq9kvmeVRbywIcuuSZCthZceDrnsNZMvLVijcuzqQ5KB6x0w=
X-Received: by 2002:a05:620a:bcb:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93bdc698d7cmr594002585a.16.1789762014132; 
 Fri, 18 Sep 2026 13:06:54 -0700 (PDT)
X-Received: by 2002:a05:620a:bcb:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93bdc698d7cmr593997385a.16.1789762013615; 
 Fri, 18 Sep 2026 13:06:53 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:52 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 3/6] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Date: Fri, 18 Sep 2026 22:06:35 +0200
Message-ID: <20260918200641.2286077-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX4Q28FS2TIo1c
 cNHp0IjqG2pihMKR8gAMhH/gGVx5d2b0RYjioNShDD6SY6W2RqChUOjPRURnCPPAsu+uxmfbt6v
 qAkWBcqNUhXbGp+ArdSy/kP4YUGB0n0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfXySZBFzrYyr3z
 yhqtUR/HbxjAauFe68rave+5D+k2ClDm6man6jENweqAQt3tjiiPErEGRwlqLXorb7xGXIpbf+E
 b2eS4FnijKnR7Q7UeGJM9XZBLQOr9RTm7XN9vddKfTJV0dcqOF/XdVEOITJD8adqAtyJmf0gA+h
 HoyZPP5fYzLlFeDX2Ljg62gRYVKMmI/1ZBgN+b4Eiwlj7sMrdzWnxSzMvypZcbackN9YPnaCL0P
 HI1wcEOodaNHKTaVZ5WssiqwV+Nn4Zxt/BeG8mBfF5sU+CcUvbOEeHaOLIpfORGh4XLLDx2HO6/
 2ZFKR/+ewy+8kD9moq9AGXRshmG9XChETEeA3v5sdhNUGlW8yTtgCMous3pSxvWdnWloAnjF5T4
 svocI+AtGQfTRB+0PisDKw8Gyfc8Q36KPQ9TxH6ex4c9vrTyDW2iDt1aHree8GDGd7dPsavWSrz
 rTf4nvNEQ6d3btzMrZA==
X-Proofpoint-GUID: WCdDxlxNXl-Hwbdr-Kj4cQFQHl6fALlt
X-Proofpoint-ORIG-GUID: WCdDxlxNXl-Hwbdr-Kj4cQFQHl6fALlt
X-Authority-Analysis: v=2.4 cv=R+mWitRX c=1 sm=1 tr=0 ts=6aad99df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=opyxpeFzTCIEhlyN3soA:9 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180290
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

OP-TEE secure storage (CFG_RPMB_FS) needs RPMB, but on UFS-only platforms
with no eMMC the OP-TEE RPMB supplicant cannot reach the device's RPMB
Well-Known LUN: UFS exposes RPMB through SCSI SECURITY PROTOCOL IN/OUT
rather than an eMMC-style partition. Add that transport so RPMB-backed
secure storage works on UFS platforms.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  10 +++
 drivers/ufs/Makefile     |   1 +
 drivers/ufs/ufs-rpmb.c   | 167 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   6 +-
 drivers/ufs/ufs.h        |   7 ++
 include/scsi.h           |   2 +
 include/ufs.h            |   4 +
 7 files changed, 194 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ufs/ufs-rpmb.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6dffdc00b32..a0067b1f203 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -92,4 +92,14 @@ config UFS_TI_J721E
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config SUPPORT_UFS_RPMB
+	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
+	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	help
+	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
+	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
+	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
+	  The OP-TEE supplicant handles a single RPMB transport, so this is
+	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..d60440ca119 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
new file mode 100644
index 00000000000..e6e0b2aec33
--- /dev/null
+++ b/drivers/ufs/ufs-rpmb.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <scsi.h>
+#include <ufs.h>
+#include <asm/cache.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include "ufs.h"
+
+#define RPMB_REQ_KEY		1
+#define RPMB_REQ_WCOUNTER	2
+#define RPMB_REQ_WRITE_DATA	3
+#define RPMB_REQ_READ_DATA	4
+#define RPMB_REQ_STATUS		5
+
+#define RPMB_FRAME_SIZE		512
+#define RPMB_FRAME_REQ_OFFSET	510
+
+#define UFS_RPMB_UA_RETRIES	3
+
+#define SEC_PROTOCOL_UFS		0xEC
+#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
+
+static u8 ufs_rpmb_sense_key(const struct scsi_cmd *pccb)
+{
+	const u8 *sense = pccb->sense_buf;
+
+	if (!pccb->sensedatalen)
+		return SENSE_NO_SENSE;
+
+	/* fixed (0x70/0x71) vs descriptor (0x72/0x73) sense format */
+	if ((sense[0] & 0x7f) == 0x72 || (sense[0] & 0x7f) == 0x73)
+		return sense[1] & 0xf;
+
+	return sense[2] & 0xf;
+}
+
+static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
+			    u8 opcode, void *buf, unsigned int nframes,
+			    enum dma_data_direction dir)
+{
+	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+	u32 len = nframes * RPMB_FRAME_SIZE;
+	struct scsi_cmd pccb;
+	void *dma_buf = buf;
+	void *bounce = NULL;
+	int retries;
+	int ret = 0;
+
+	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
+		bounce = memalign(ARCH_DMA_MINALIGN,
+				  ALIGN(len, ARCH_DMA_MINALIGN));
+		if (!bounce)
+			return -ENOMEM;
+		dma_buf = bounce;
+		if (dir == DMA_TO_DEVICE)
+			memcpy(bounce, buf, len);
+	}
+
+	memset(&pccb, 0, sizeof(pccb));
+	pccb.lun = UFS_UPIU_RPMB_WLUN;
+	pccb.cmd[0] = opcode;
+	pccb.cmd[1] = SEC_PROTOCOL_UFS;
+	put_unaligned_be16(spsp, &pccb.cmd[2]);
+	pccb.cmd[4] = 0;
+	pccb.cmd[5] = 0;
+	put_unaligned_be32(len, &pccb.cmd[6]);
+	pccb.cmd[10] = 0;
+	pccb.cmd[11] = 0;
+	pccb.cmdlen = 12;
+	pccb.pdata = dma_buf;
+	pccb.datalen = len;
+	pccb.dma_dir = dir;
+
+	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
+		ret = scsi_exec(scsi_dev, &pccb);
+		if (!ret)
+			break;
+
+		/*
+		 * A power-on or reset UNIT ATTENTION is a transient
+		 * condition the device clears once it has been reported,
+		 * so retry it. Any other failure is final: stop and
+		 * report it.
+		 */
+		if (ufs_rpmb_sense_key(&pccb) != SENSE_UNIT_ATTENTION)
+			break;
+	}
+
+	if (bounce) {
+		if (!ret && dir == DMA_FROM_DEVICE)
+			memcpy(buf, bounce, len);
+
+		free(bounce);
+	}
+
+	return ret;
+}
+
+static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_OUT,
+				frames, nframes, DMA_TO_DEVICE);
+}
+
+static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_IN,
+				frames, nframes, DMA_FROM_DEVICE);
+}
+
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen)
+{
+	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
+	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
+	u16 request;
+	int ret;
+
+	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
+	    rsplen % RPMB_FRAME_SIZE || !n_req)
+		return -EINVAL;
+
+	request = get_unaligned_be16((u8 *)req + RPMB_FRAME_REQ_OFFSET);
+
+	switch (request) {
+	case RPMB_REQ_KEY:
+	case RPMB_REQ_WRITE_DATA: {
+		u8 status_frame[RPMB_FRAME_SIZE];
+
+		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
+		if (ret)
+			return ret;
+
+		memset(status_frame, 0, sizeof(status_frame));
+		put_unaligned_be16(RPMB_REQ_STATUS,
+				   &status_frame[RPMB_FRAME_REQ_OFFSET]);
+		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
+	}
+	case RPMB_REQ_WCOUNTER:
+	case RPMB_REQ_READ_DATA:
+		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
+	default:
+		debug("ufs-rpmb: unsupported request 0x%x\n", request);
+		return -EINVAL;
+	}
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3d96a05281c..2ca4fb2a020 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1458,9 +1458,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..9f55735602b 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -10,6 +10,9 @@
 struct udevice;
 
 #define UFS_CDB_SIZE	16
+
+#define UFS_UPIU_RPMB_WLUN		0xC4
+
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 #define UIC_CMD_SIZE (sizeof(u32) * 4)
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
@@ -809,4 +812,8 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
 #endif
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..cc79b6dd4c4 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -183,6 +183,8 @@ struct scsi_cmd {
 #define SCSI_WRITE_LONG	0x3F		/* Write Long (O) */
 #define SCSI_WRITE_SAME	0x41		/* Write Same (O) */
 #define SCSI_UNMAP	0x42		/* Write 10-Byte (MANDATORY) */
+#define SCSI_SECURITY_PROTOCOL_IN	0xA2	/* Security Protocol In (O) */
+#define SCSI_SECURITY_PROTOCOL_OUT	0xB5	/* Security Protocol Out (O) */
 
 /**
  * enum scsi_cmd_phase - current phase of the SCSI protocol
diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43..1bec3ce73a4 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,4 +20,8 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen);
+
 #endif
-- 
2.54.0


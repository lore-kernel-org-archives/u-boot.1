Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF5606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lYtu1Zhl;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oy7WZQyZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V7qHk7js
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D7954060A;
	Tue, 27 Oct 2026 10:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FwzITYGNEvn; Tue, 27 Oct 2026 10:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A79940581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793098014;
	b=CSkJ0dy8YKm2B0iJzzSlB+FhhzD5Lql+5xLeFXTH5OgfkV5aIaOyc8e2LwZ9j7h5iqoF
	 /o9vRraA1szfFLjjl1A8cjin1O1qlP75wLssUM6SBCTl9n9kMlqZQGpIPQFQwmfcVbKYD
	 orOKytgIsQbzI6NxW0XmOst4kY1SFQxP/NByvI6bu5wyz79k01jbuYd0UMnWsiHKNqG7Q
	 u6D0t9C9r+/W5q7T3OpcaV47CnDxMizYDhI0za7mKg0VT/L0V1lLIHUK8lx5EcdN2RM5l
	 RmB74TKpXnv9J+DiH5UJFtTXdoTPJhGom8dozgQknxa5vuBEj0CMSO49hL/S7EpTpww==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793098014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
	b=FQN/d++a4srxjwat+wK91rRAFVQE7FdRll3MmzW+cg5/emYeWjyfxghpVv3+IphMwWjX
	 Hx/2otUE9t8nS3VhWbTGV8DSdr6YlNOFRdmB5QflPRt10bxmPJqB/jS+Y5Uf0MA6H51j5
	 PT9w26uxp23saOfiHL8var3DByVfWgi4p48atmbcNfwtvHFm3UCQHe93qYcfnGO5eqsZU
	 /oVsIehjyFFQ1skEVIJ66lWgrdhk4gja4W+mFRtI/iE0wU9FXX07CtOG6uWWUEyFmScQo
	 kevqYMygWzWTP4WPR6I09hsr4mzoTldcCWyGzXh4xyYBPMvvrFZTuxfyziYmK+n/L7Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oy7WZQyZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V7qHk7js;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793098014;
	bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYtu1ZhlYdG+QL/Sj2K+2LWfdB59XJzs0jW0lEE+OM1C1X4zhVFo7gWDMAZ36y3jB
	 rG5WZLpuSZbFbF6i96jvm3/VkNYBOR7r/M2FcEQOte8TBtTI4TcHi7BtFucsIqS7oH
	 TEPoFWPkNnPXwRJL/OsW69EHuG5LVCRsDXon0KN3mUuH2SnEIZBwuoKqdpxh+SePf9
	 sw7FPNXNdq2v3Z7MR0UIRWXr2X6GOc6R4AUn6A53qjvj1Z0/yJGdgHPNIlXEYTXOzj
	 TT6I+ZelGDIF+gHFrOPo5TFlGfOkKiSTatCWcK62EW67rPJ8j9YTRzmX7fu4E0EglE
	 C+J5ewvsH9zzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A79940581;
	Tue, 27 Oct 2026 10:46:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA4DF4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BCCE40581
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HZ6PIvPxe4b for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4156F4056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793098012;
 b=V3bISpu34WaX5/kAH3A3BYuz8tVuxS0Mw7qr1inlkSoIXMD8u+kXHShEifqsZRDgKzvk
 uYY6tqienE8dg62SehjUPEFfT1xf+9zF5tHJEQYz3NOjP8Ur468INInWi1yknngaHjhXr
 8uf9j1abiALUR2YnrbBhYlLisRx2iTqZxMLmwH7r9A65adhyQ2YLp/K4QZVCEcSCm3dpD
 JsdIGe401FkOAmA2HsJpOcsLwIn+8N94Qvzx3ATCNxR+XPRPASUWf1L7HqzmfCZE1yDKK
 BdfgoM3JThBz1853vjZ6r/kIYN1bKtZWstOeyw4Zx/FLybLEcd0MTWMX9SD3B1a3ZSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793098012;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
 b=TuWtMpiBq20qoBRmfO6F/QqZvRPRe8ztz3Spsnl0ecsRLv4BISljzAuImzpXX/tfArjg
 Cmec+EgosGT4BSVTYdZFDtjtaiHLea+uDebqqyVIZVr3AV9cvqv5s50QnYHvUvXtsuv2M
 /wJTsiLxCpFkIUX9ezbjQCwtag9gHShM+ci3JtQtgXAtUuo54ZI24Csx2w8i9klwbjO+D
 0VWMgCFWzM+CzCWvDrCcIvPmL5pVWOkeAMLnThmNiFYecefd1pAtz6gJRd4exjw+mhTyV
 KZroYcRkGhTGfSv4xQzvs/XhuM01m7Gz2mW5AqHo9UVU3P3CDDRJx4ZgdkYt2l9hT5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Oy7WZQyZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V7qHk7js; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Oy7WZQyZ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V7qHk7js
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4156F4056C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:46:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAdwBk2458098
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=; b=Oy7WZQyZDrUFGFQD
 taEIjvTgny8wLowGrqzur/wSd1zRyPFRe6Ajyff9Q0/aStPpg8jf2lhGhFgShhmI
 2i7kt6FhthGVTlqe9vfQRm3Rd4Cbg0jAAU0hYDI3xHGjyNIsogh/ypM5hG47LOi8
 D/bK/go5OLjNkZc6IpkGco1Tkd0K2Wpntba7t/JKIgtABULDhcLr8SghmH6WyhkC
 nADKQyCAf6YoS6ZsBRrPKfx46KmvxZs+XpaQ/tyTMIRVQSIETwKd3MyyL5w1gT8w
 9nKpLrbZfNIMKkES93lDE0LJ+OW3eJJ8MVskv8o2GDwKLJK8Ci1MQiz1dry84nLz
 GR+Bgw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbt9uyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:46:49 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-836c9f68dcbso62478927b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793098009; cv=none;
 d=google.com; s=arc-20260327;
 b=JNlcY1FGM2H0GuDGuHBxhZNHyZDqFSVWxJaVyAFueIm23V74GvWRRZw8LEkeeN1iLJ
 IbWLUh09CTx1QfRGjExVyifh6OEV2mt8vQpAcE67uhmfbtA1pkT2dHjesf0AxWDIqunp
 M2solwFb3/vDPSeCH49+9GhZiZ49J4M4T3b6mOGM5eOoaz2ZfaiAf2SUayp4C+nnyVj+
 2zFXAheCgW45jHdAkRFN06DDeCyMY6CqiUNFp9UpyIyMauuFDtwFf8GPXoyUqxK+XnTd
 jMSHHYGO1dHJqMAI5Lkgh8BE9Qr/0VvOcc5n8A34luMND0qLi/NJFygCBCFZ/Ihxggqr
 blRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
 fh=Jg5bQQCnJIkNOl3UY2I44dU1lUGCGtwp01k+orU9VDU=;
 b=C9T40QVbKOPi4ieaVnEZvNCv9A9n7hFTqBb0af0/1yORJjcsIeYTBSAmeXsamUuRjK
 jNYYKrPid0d81bsFBVYd0RBZz+0+I4ew4NR8u/+2VVN0EiwnkgvMY4ADG2AGn0WUNmHk
 pS2QPNCclnTpRirHw9lmcGVVGYAj+WutFTAiyWsnfgBLj3F7nFlI7lrW3d1AgBGZ94ks
 yQsuPEw2g8fb0lqYMBsmDsT/DIiyleZPECM7koKBPVhv6Hdw2bDBsBftKULgXzeK5k+7
 7lATr34WKERVWr4VBM5olUfoQy8vaKMgm2YNh10eKF5p5X5uE/PyB8DCvdajH/x3ombR
 C8fQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793098009; x=1793702809;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
 b=V7qHk7jsC9SVP+wWrsHJPSQhcLWjMAMRePkSfRRpmTMq7AqHG3odlnYN7XoXnZtDxf
 qnP/G1d8V4GGyePO52uL93ph3DJdX/LZ248aHkmPaqfNWmOvxdyn5TZrTEYRQdLQTxoD
 Z9mv/zl7oaP+rKKGjjEm5HplpyIr9rfF8oxmj7HM9o7GPiBGlimqPdGGDJ9E+i+82q83
 rDm4DZyZ4CouUOYZatWqGpwUblCpiCotrUsvC0vbMQ3XE0EJdvHI48drt7S026LN083S
 oR9zYon6fs6COkZH+MQR52DN1Dk4WcHfAcHI4RYw2Uv3YguDQTIlFqS5IS50bZkIgwiX
 MIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098009; x=1793702809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sn5EXFFBOQmQycY+tVu6dCoppqUy2AxIsBHLi1Vq8ds=;
 b=OG9t6zlzSYBTeCCgLNEvECaOMkJoCY08wRkMjw9/zTKCUKZqWC4eRrGWaMQ8XIGKmX
 KbatNmab3vL9rr2/+gqM40kBQ4vyxYcKvS6qwnDZh2y27bmokTBM8SGUEAwxB1bpwF60
 qMLDKnFYUxsLvUnc8aYU+OufnKwn+Py7IU5OkD+Iyw3Kpd7jOrhyyj5xtarjkO6R3L0C
 2ZTUNVD2q8HDlJc9VUVf6aGuG+Imt4EeBBQdABRrFTrx5IzEUbs6wgM2nJ1e42jxHqne
 WqxaX5BYAC4u2VDLoLm+owUq9CsLTx5gxW54WIEjLxH+oRHCckaQno5evtSy+9zj01hv
 W4dw==
X-Gm-Message-State: AFq9FYLECJp1NQWwRj2MLmxSBpc/zjX0Jc5zVzz/HGDr5k3/l5LG0hxJ
 V/1nYnJMj72wp8KS1di6Hb/52x+pMZJAeD00IPSLCymQHX3zm1ZHnL8b8SoeG5NV+7tOT7cSvUr
 g5R/gYgTk2uxECrsloUqwYrU71IAIPrhvM0GWK22YcMKu9xdTryrPqQjJD84eFNLIOHHYTLVKk2
 d1Qgyrte+DrEs9sSTzEIwkMiz1OSwrIGa22ZOsKu/CeUu03s9TrCXtUuly
X-Gm-Gg: AYBFou03XMaeghZlZEWO6YYDODY72uKqzQSzND8/thNl/kz89qOrddhTHL/mv7VlLMw
 Db4r9sPwX0h1ypyu/hkbLjIvnqsgxMOIzAa4jWtwdU1fuhk54W/MY3S6OJ8I9kUGzJ6jx+N1aBm
 mSSxxnm9ESFhOpjo/63qZpE2ASTOg138tqXblZknX+8YgkTsru18lbGDQ=
X-Received: by 2002:a05:690c:11:b0:8af:e4ee:a91c with SMTP id
 00721157ae682-8b166be40d8mr56527517b3.41.1793098009095; 
 Tue, 27 Oct 2026 03:46:49 -0700 (PDT)
X-Received: by 2002:a05:690c:11:b0:8af:e4ee:a91c with SMTP id
 00721157ae682-8b166be40d8mr56527327b3.41.1793098008585; Tue, 27 Oct 2026
 03:46:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com>
 <179275512301.1510420.5223585191999112458.b4-review@b4>
In-Reply-To: <179275512301.1510420.5223585191999112458.b4-review@b4>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 11:46:37 +0100
X-Gm-Features: AclHuK8FytALZrCCI6REdjEc-u3ivzsFL0zm9HQNBwhD-sTDxgy0alXxe9NHu_M
Message-ID: <CAPzfCAYNK_eBe9kXtq29TopWK4=7XwdtSk5F5k8eJ7=5k=c1jA@mail.gmail.com>
Subject: Re: [PATCH] net: fastboot_tcp: implement the download data phase
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Guillaume La Roque <glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfX4pXUS6+ULYar
 AERARwYm8UFIMrmIgE8XlRlsUitF4ZqLJaavEv2+s1NRmi/I7Arqdnxfb0WwLlK/Aqq/0UKAqBB
 014WmwmIapkuGfXkW0wzaOMrXj2oioE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfX2O0hqmgOXPCD
 F84OKH3Iw+YzFWTtNCRlvyixcUpNtE7tPzr+8A+2ppdsqAG2CKiLHfGEY4m8HNHFZ7EcAimS1RC
 jeRCZtZS5gSd7TblRYmEJgBm04yjMDpZ5C0v3wHse2Bkh4n2tAgqAa/PFpPd2X2ngV4XsEXSSVa
 zFMsLLh4IGnS9GdRWx4t8JTvn7pKDNDp6UAXS6yQqmW4hG8j2bVG1W32OQZg1mcnEW+NAewWclC
 3Y00U6/U2FVlkcqVb6SJ8hII2Dqv3AiYZMoQf4by8Bmmqt5xSGJug2+zbYcKZbFpyiZW0fpYWV8
 5Fu1oUutfsDf6o3aUjTf94F09nfc2mnUg9mAckB8v4uCQNnnmyE1vMrFDKcL5ppATAIKt8hxzVP
 UnzvBb8Tnmnsx3PumMruh9v2Yv0uzskHyunobQLHixGU0/O02UIxdh1nGO7R4w9MHR2C5dZhIEJ
 301X9x8cBYJ45sjTKmQ==
X-Proofpoint-ORIG-GUID: 5BMj75ghPcAWyBUqukLMtjxlJqD0jeJW
X-Proofpoint-GUID: 5BMj75ghPcAWyBUqukLMtjxlJqD0jeJW
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae08119 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8
 a=11izo87qiFOaKiINlZYA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Fri, Oct 23, 2026 at 1:32=E2=80=AFPM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> On Thu, 22 Oct 2026 14:17:00 +0200, Igor Opaniuk <igor.opaniuk@oss.qualco=
mm.com> wrote:
>
> Hi Igor,
>
> Thanks for your multiple fix in fastboot.
>
> >
> > diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
> > index 3ea25c997fcc..ed32e5311b45 100644
> > --- a/net/fastboot_tcp.c
> > +++ b/net/fastboot_tcp.c
> > @@ -16,17 +17,95 @@ static const uchar *handshake =3D "FB01";
> > [ ... skip 37 lines ... ]
> > + */
> > +static int dl_consume(const char *buf, int len)
> > +{
> > +     int left =3D len;
> > +
> > +     while (left && fastboot_data_remaining()) {
>
> varaible use in fastboot_data_remaining was properly reset after a succef=
ull
> download(fastboot_data_complete) but if download stop in middle or error
> i don't see any reset, do you test this scenario ?
> initiate download , stop it from host or unplug cable , relaunch a
> download, if i understand properly while loop still use in
> fastboot_data_remaining value from previous download.

We've had a pm discussion with Guillaume, and pointed to Carlos' patch seri=
es:
https://lore.kernel.org/all/20261014-ccaione-upstream-spl-fastboot-boot-v1-=
2-d29df15fb9b8@baylibre.com/

It looks like he's addressing a similar issue with reset, but in the
common fastboot code.
I'll wait for his patches to land, then rebase my changes on top,
re-use his reset
implementation in tcp fb code and send out v2.
>
> --
> Guillaume La Roque <glaroque@baylibre.com>

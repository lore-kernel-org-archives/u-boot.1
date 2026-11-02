Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F7606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FeirxDcE;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CMCw3JQ6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SONhGuVi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA8B360681;
	Mon,  2 Nov 2026 05:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wtTqxkDnK8Ro; Mon,  2 Nov 2026 05:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66CF460684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598544;
	b=SRcqtBvDB8ffqUzeJ8MdS1+krVApLwE3rusytlXirotuBQ+3sdq9DZFFd10p56SEJXII
	 dNlTqEtt5Gu3OduGJVYpCqS7eKV8DvUd9Q7LtOi0awbmpGgasPe67IkOsbhI1r76NAlBM
	 O1kVPd5vuWVeZUbOdu47UoBHCFS7KZRMnTrx3ugv327A3OnAe2VSPSpNULZtUp+MdQy31
	 7vdLeAS3G6nEgxq8JnHUuqinadP7SRmLFWe4CJ/toXREXj57xcVNrWWX98SVR+rbC6nD+
	 IFHTiqZ1kUP2ETDl4mb9PNKQxOZvLYvjw0DE0YmzX4dmqRg+EEpsCA8OSMnC7OYvRkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598544;
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
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	b=G7YyUXzyO2yJAFGmHdpOJjGa+z/bUR3FVSL8jhM3EebdsglQxnZfucNVtjrMn3Wu5wgM
	 2i5gXvzTBYvkWbWKBoSNRDxBY4nVMR5bKP+z26ZuQCgTguj3a4wn1zI8igzPnOpcuSHOs
	 +XBM5GOsVrdm954XnbEJWyeSU7FNJud6nAl37HIfQiFm3bQLdQNOkV7xkwXTkZaGFyiip
	 x3XA41H03jwGHITBpJwJn2I3RDgj24hv07f/rrWWv+uh+GaCVmqN2YztZegoeG61Oe/zW
	 vP1pjFA92mVm96+GL6V4nFdcPKUyYLTL+UgRhCu+bn6MuEExTJjIz2Ic7jepNv5l7yA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598544;
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeirxDcESVdHzl1D8kIfEz5Ce4mHrHVtmlvavW3VwQr45vGoeFIOjsIi4p43Xf15R
	 9qdOziuwcKL3vkrzkgGi8INaAYXDZIih8LXPnMK/NxB6CPhO3ft/5WkjoqrN6ZSK0n
	 0pvjZq8RhpRWgdxDe3RLT9YJDfl4G9YPjDBJ7YAf6LYbPl+husapyypfG7lhou395S
	 4lvRP05mbxIZZW037xlR2VkqMnFPhBwRHitUlg8+Y8+uQ5KCWp9Pzd47PNhtmPu9KJ
	 XbXE5kHsOaYR5eo8kxFLwrkRx4R9Xd5NUPAyGCE4M4C1jowBxYv0Hru86j/r/fygoO
	 UClGnmb3wH/Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66CF460684;
	Mon,  2 Nov 2026 05:49:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 92EF0435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78897405DC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hrl8zjpsFMki for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16F23405B1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598541;
 b=GH6A1ZQTVdciqRHacM5qnzvCOt+pH5WyLJg46fS5DQKJ8CGU/jH4rCPV5vV3JMtRRMgM
 eyW97ouBW1mEQAVGcYvsJvYzDKZtohSUlM7l3BksvBU2DAx6IOIV36Lf8ZPejqHa6h1S4
 azDX0GEgPwV6B9IFGDqy2ZNDSwH+y+coLs8UnA3TAshziSBVTqmXj3jNsN9lwuG+r9ne3
 /548OT5f2owPMaoFdcs1fS0Xjn0oT66aRc1cTiAgdRQxRP1aHUE3RZ9eridIN60VgWCew
 YV2ALTU1hiicrzcB796rneBXBeo2NCxA07oNL00oJLjp4R8nmaWQ4d/WtJgiOfJ2M2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598541;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=PTN3Pm4bBUIvX4fKauPZ0LvacaYoVkEYaJBIVgewkWCTe0YO8paiHKnyhXafdtccvCh2
 XEJSBdt2ofb25gKV9Puq5vCVyYCV/Bh3RPSZUc4GRCgeIqs2mDRruAPWIC+qcAPxzf1Ai
 PpYdGjY0RfZkDt0eeXac2L9a1lZ6B3xbzSuptBglNcDYeTbhCgw6p02/lkbq/Y0m6eDT6
 itDgP2DJyfk1gyrxHKNnNluIUVgIkHmE1yLVrGVijSmHbu746wKTUUHilRl2KqwtL+3B5
 fottbuxv6LbpJbXjr8HmfrDJmUgbvVeOfCOdP/3R6frLoot5gkkUWcFHBT+Fpd4i8Dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CMCw3JQ6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SONhGuVi; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CMCw3JQ6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SONhGuVi
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16F23405B1
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vMa42745507
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=; b=CMCw3JQ6yWOD+zNT
 R88olAZO7fQhv3JVvfBZdf1UMG9KozNQAJBH9qOE4KYFq1LFelVSKq0Yf9Uv/Nji
 lWsM/tIAdHfMgRGFh5sDpVF8X6V+ZtxUb3N56R9LSrT4V+JD5FuaxYHtDDvRLNP/
 Qvw80VMqGpIzdKF4gJrFEVw7Y2a9v9JIh7KqWN7m+ww5IHYToLDoUncHTtap+NHs
 iIGAwdETeU+5Ehe8MZx+luvxuX8FjMraXmJRiHLsg2MZi5p/6qIrBtQMlps++EW7
 5lU5jQh6R4lufjahbCr12k6kQgkQajxr4iM2b/hek+1XVylKAL6cHJM4/BKvgYWL
 DZk6nA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dudas0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:48:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b0d864826cso3527402c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598538; x=1794203338;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=SONhGuViTKN33X9odFAgqoMKbUk6GNMc9tY6c+3mBhOpWrY6jd4HbmoIo6fz+TkKGI
 +yCLKBoBZiVb/qBeejw3LyfS84oCV+VwowXUfGgOLk1NuSMsHPukaw3uLoYAA6aHLl+P
 1SDbcQO7wuSk/2cAvlsbLSuXSdzjj9P7+Ki4iKfitRbrw8yh1A+cHAFLlUnDZrcKGGha
 y5JJbVOJg/L5oPHGY0ZYR9HUauy/ypLsu8sl8kNj4oHGdXB3hR5mvi8YvyHSrdtt046/
 CrE5ImOVsH8rCxwIAOkciZJp77iUDNaIa+p/xsaU1f2sC/UqqIjoUOT5auuSkxS72A6p
 PmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598538; x=1794203338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=eTnwCplDUxVpBXowwDGnkYlEoDyp8AK2zSXMi2aepTjUtFL3GVLhoWpAeSnQvYQ6+C
 0USh7X3qydxCW3aVgWZ6lfYlgod3pbokxts0p06ISgNV7mxPC/kenUfGyi+GcDbh6Zrl
 BBfikFUvnhrkZI7ge+JuR/9zvjsOlOQ+q8OlAGjwes6lzL1Yy1KdJCjJ0e12WiC/pWkK
 67KHaAdv8msXQB4H/fTkU8mmOF32UBNbFa1Yz5n++kN68Bys4ewTdCQTV4TNn9mkzxW+
 qPuOJS+ZIyiA6IEGXyDwi8GcZQ4Mzxu92l0GPCJlNChCkBR/jT+fS4eTubesZqJ88r5J
 kCqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkq76JNNnxwhO8jnThL79QJRQGwQ4lwadj2HWdFNtfEWZQPUugFiIhP9hFUQPYogwNFO9iG1g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL52DgcTzLz3QXVH2IvUwKBD++O/DxO5Z0zXkCoQSMCmEnhZibL
 TvzGglJtOArUJpGwEHOmAThf+j22Qx/tUtEjBM2I4oSEJU06agTuhKnxF6QlMZBXN4MbGb0EN/A
 bY++hZlY2Ch1jIsKmq3U26LypORnYDeZQATEmZ2OWw3+uFBWnazY4Z56tpQnBn4x+pKGFzlw=
X-Gm-Gg: AYBFou0+qwNMTaP11vK8KLBPnGH+uHv4M+CPvUWb7K0HFKSlj+EsD9mUdhdhs2OYBPs
 ZmHdYPt9dCBAC/hdmx3JDUWYsL5CC+3Tm6kYFTnVc3zM6yBQ1ja5TetL4P+j7vtMcLPIivlnjvU
 aGaKdQ8ek6GRw4qG0jeesXtBRdhA0xJYo+PsWR2Uh0f/sG9JxsW+LSXqkZ3n6kXvZivyFgK9HdT
 oDw7Dm+n6Rh1rVcAUr4rNqbNsaKUJRqEq8YFDSIxiSIAfTSyzr80xw8g/b++4aa/AR65sltTY7C
 r9iaSwYBDzA1PBIuwrhPilr8H/FdlQPLTMJonWpT+XjhozEGM2wBd87kxQqxzV4jZxTrfMfM7OG
 3xNZFu2Mc5UfwypFI6RaEbdQ/EuuLIUlIguFLaEjszf4U8JQOk9nFjAUiA5reD21a3d/yBDOsdn
 LrjlXbyOL3ViJw0bl1hBt54AoOV8pZqreL4N+iVMdJfijFuolJnlW8HVCP/giVFxr0+j0lGDdkq
 yGVJg==
X-Received: by 2002:a05:7022:3f04:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-1ac5d5aaeb1mr13993648c88.43.1793598537386; 
 Sun, 01 Nov 2026 21:48:57 -0800 (PST)
X-Received: by 2002:a05:7022:3f04:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-1ac5d5aaeb1mr13993626c88.43.1793598536808; 
 Sun, 01 Nov 2026 21:48:56 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:48:56 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:33 +0530
Subject: [PATCH RESEND v10 01/15] misc: qcom_geni: Add minicore support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-1-224d421c6201@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae8244a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OeJ7P-MtQltDYP48I0AA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: CpNUuC7QYfsKcFQuTsOKuyultfhoMFKR
X-Proofpoint-GUID: CpNUuC7QYfsKcFQuTsOKuyultfhoMFKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX5mfJGesPikQx
 QcKUdU6bqGi54EWsqyCVqWxjFrxC12ChWwc9rWYfcLvEyj4KveF36+4DtXduBNvgwcOWRQecYGu
 afdOXK7pQohcPAgSHrRmFUGrgc6XZF0boX+yl5f+SGQl1RU1yb33j4VV5K093M+irrexEXJ/GhS
 3g4r7+dKtLGHDtEjvdd5WsZCt0pbHaEgZKSeFcd07HnYJhSglJ+xc0RuuLwJafWCK+0y/l8ogw3
 /vWEEQygi3EBfMBXeBk191BcRJjPACI7PZbM9+HB1/tHGSJ6OZDEP/voKbg6bW1B7/Ivwn5ycXe
 SwcmyG0kVbUtgRxP2ucM3S800xeduj6U4U2bZX23nk+vV+f1+zY+Bh5tmKVWZwjouKNclkgYjoy
 m0anJin7bcEwFlypKwsNuDH94x2LaTqktl5SNkJPWDZSGLUOyKL66NVZZAPLYAUBacOaMA62dwo
 aV6r6v6fxvAPgeve2iA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX3s7eCrh/9VDN
 0nCRl10d8se6rAA/9WUZb4ct5sA2KnQPBJlkPvsi00W7Z7UB8F/rXJDDL2BYnwSATAdUDo6cvaQ
 39KOq3hp2r4FVQ6cocw1M3uQS6S/tN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
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

The qcom_geni driver reads an ELF from storage and configures a set of
registers and programs the firmware to the GENI Serial Engine (GENI-SE)
wrapper device for the expected functionality.

Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
wrapper is pre-configured for one of the functions defined in 'enum
geni_se_protocol_type'. Hence, the firmware download is not needed.
Only the register configuration part is needed.

Earlier, the boot stages before U-Boot would configure the GENI-SE (to
access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
(i.e. boot ROM) doesn't do that modify the driver to do the register
configuration part alone without reading an ELF from the storage.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/misc/Kconfig              |   6 +++
 drivers/misc/Makefile             |   1 +
 drivers/misc/qcom_geni-minicore.c | 103 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c          |  85 +++++++++++++++++++++++++++----
 include/soc/qcom/geni-se.h        |   5 ++
 include/soc/qcom/minicore.h       |  25 +++++++++
 include/soc/qcom/qup-fw-load.h    |   1 +
 7 files changed, 215 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bde5c640de8..0b7894f131e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,12 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_MINICORE
+	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
+	depends on QCOM_GENI
+	help
+	  Enable support for minicores in Qualcomm GENI and its peripherals.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2daccbba74d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
new file mode 100644
index 00000000000..12c57bdd8b2
--- /dev/null
+++ b/drivers/misc/qcom_geni-minicore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
+
+/*
+ * Register configuration for the QUP minicores to setup the corresponding
+ * functionality of SPI/I2C/UART.
+ */
+static u8 cfg_reg_idx[] = {
+	/* 0 to 18 */
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	/* 64 to 113 */
+	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
+	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113,
+};
+
+static u32 spi_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
+	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
+	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
+	0x00004000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
+	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 uart_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
+	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
+	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
+	0x00000B00,
+	/* 64 to 113 */
+	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
+	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
+	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
+	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 i2c_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
+	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
+	0x00000000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+struct qup_mini_core_info qup_mini_cores[] = {
+	{
+		.serial_protocol = GENI_SE_SPI,
+		.fw_version = 0xb02,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(spi_cfg_val),
+		.cfg_val = spi_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_UART,
+		.fw_version = 0x405,
+		.cfg_version = 0xa,
+		.cfg_count = ARRAY_SIZE(uart_cfg_val),
+		.cfg_val = uart_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_I2C,
+		.fw_version = 0x204,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
+		.cfg_val = i2c_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_INVALID_PROTO,
+	},
+};
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3133f85885 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -21,6 +21,7 @@
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
 #include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
 #include <dm/device_compat.h>
 
 struct qup_se_rsc {
@@ -34,8 +35,11 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+	bool is_mini_core;
 };
 
+static int qcom_geni_fw_initialise(void);
+
 /**
  * geni_enable_interrupts() Enable interrupts.
  * @rsc: Pointer to a structure representing SE-related resources.
@@ -163,16 +167,54 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 {
+	struct geni_se_plat *plat = dev_get_plat(rsc->dev->parent);
+	struct elf_se_hdr *hdr, tmp_hdr;
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
 	int ret;
 
-	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
-	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
-	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	if (elf) {
+		hdr = info;
+		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	} else if (plat->is_mini_core) {
+		/*
+		 * Minicore controllers come with pre-configured functionality
+		 * and don't need a firmware download and just need the register
+		 * configuration. Hence, skipping the firmware part and setting
+		 * up just the register configuration related information.
+		 */
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		if (qmc->serial_protocol == GENI_SE_INVALID_PROTO) {
+			dev_err(rsc->dev, "Invalid MINICORE protocol (%d)\n",
+				rsc->protocol);
+			return -EINVAL;
+		}
+
+		tmp_hdr.magic = MAGIC_NUM_SE;
+		tmp_hdr.version = 1;
+		tmp_hdr.serial_protocol = rsc->protocol;
+		tmp_hdr.fw_version = qmc->fw_version;
+		tmp_hdr.cfg_version = qmc->cfg_version;
+		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
+		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
+		hdr = &tmp_hdr;
+		fw_val_arr = (const u32 *)qmc->cfg_ram;
+		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
+		cfg_val_arr = (const u32 *)qmc->cfg_val;
+	} else {
+		dev_err(rsc->dev, "Neither fw nor register settings found\n");
+		return -EINVAL;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +392,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
+	bool elf;
 	int ret;
-	void *fw;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +420,26 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
 
-	ret = read_elf(&rsc, fw, &hdr);
-	if (ret) {
-		dev_err(dev, "Failed to read ELF: %d\n", ret);
-		return ret;
+	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
+		ret = read_elf(&rsc, fw, &hdr);
+		if (ret) {
+			dev_err(dev, "Failed to read ELF: %d\n", ret);
+			return ret;
+		}
+		elf = true;
+		info = hdr;
+	} else {
+		elf = false;
+		info = fw;
+		if (!IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
+			dev_err(dev, "Error: f/w ELF not found and minicore support disabled\n");
+			return -EINVAL;
+		}
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
+			plat->is_mini_core = true;
 	}
 
 	return 0;
@@ -473,7 +530,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -518,6 +575,11 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+	if (plat->is_mini_core) {
+		fw_buf = qup_mini_cores;
+		goto mini_core;
+	}
+
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
@@ -544,6 +606,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+mini_core:
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..3063b37010d 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,8 +77,12 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
+/* SE_HW_PARAM_2 fields */
+#define GENI_USE_MINICORES		BIT(12)
+
 /* GENI_DFS_IF_CFG fields */
 #define DFS_IF_EN BIT(0)
 
@@ -248,6 +252,7 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
new file mode 100644
index 00000000000..9f2071ed86b
--- /dev/null
+++ b/include/soc/qcom/minicore.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _SOC_QCOM_MINI_CORE
+#define _SOC_QCOM_MINI_CORE
+
+struct qup_mini_core_info {
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 cfg_count;
+	u32 *cfg_val;
+	u8 *cfg_idx;
+	u32 *cfg_ram;
+	u32 cfg_ram_count;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+extern struct qup_mini_core_info qup_mini_cores[];
+#else
+struct qup_mini_core_info *qup_mini_cores;
+#endif
+
+#endif /* _SOC_QCOM_MINI_CORE */
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..df8a615b46b 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -14,6 +14,7 @@
 #define GENI_INIT_CFG_REVISION		0x0
 #define GENI_S_INIT_CFG_REVISION	0x4
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define GENI_CGC_CTRL			0x28
 #define GENI_CFG_REG0			0x100
 

-- 
2.34.1


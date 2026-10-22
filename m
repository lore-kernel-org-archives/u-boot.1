Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6947606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sOn2FJAA;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SCfiWglV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U6Vm2cR8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE08E81164;
	Thu, 22 Oct 2026 21:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LP6jJWzNbp6; Thu, 22 Oct 2026 21:34:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09BB2811C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704869;
	b=MmLLOz7DPg2wamBu5/5PpOC1W2m3EJgmiKOVfxTaITjz5sCzLuPtqEJ0pU/zOyXCiyb/
	 MrcFj/ijKGyFyGT1IVT1UPibyc0OZspR24Wh7wcirh/UcuvS7kswkyLPVNfDzZsvloqdX
	 EYdTfng80WF7yWAD9yKThBmgq650tB7K1RqadnXWdo6WClzdwkIRAs7Vp4bjKycDJS2YV
	 UIKTfibV7Mrrfyy0Vfhb7U7/qDQ+/8b231z8tboqO4STltBkU8FtoKgJ/yM+qSeNfyz9E
	 x+Z7ohvI4lv37/HCHYhR8YkwUY9lEUPmTeL8c1pKlLiZS6mo0JwFyWqCQz8aPJMavBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=;
	b=fm3ncEjPN6qWXVi0t053PwYlxtvkb//aNbGYyN9qwR2mrQCYfhIGW2/UfK+B/LLuYdEt
	 19teuHjusLJT50qIXZVM83Po4sj5rcnhdPSsy5a88S3v3Iq/IxclJBBq8x9TjyRM25ZWL
	 y/8WIEHaDMQ59EF1ee0ydmOwLrJsLwItIlWRMErauoP+0SEWxtDC/4WFzDE6GnlT17wWy
	 e6wNa7ue3jX72AbntvMUTmSYjSnd17jcH4zBG6leYz64wX1dh8sBNZhZm7oyJiES7AgWv
	 YeXfjeKMARbW0vcugtmQSqQ+XkXanON+/TeaT/1OklobIYpN+o6K0mlNe5CGzVNNj/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704869;
	bh=JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOn2FJAAgVBoAr0fX8IDWjI68ybOzKL3ES1CfNYmDnUD1pDIl9WcxqaK7MVKFXfX0
	 B+HMmEpJkFCfVew81Zdb6QjtvOSeqV8J9xyZ/bXRx1T6Pi37CxwKf4msx5gZKZhD4I
	 YO8Zx95Akjn9SC1dfhP8Xns4E70S5Lzggg76gGAmWlYDlilBkdAjcLQqS1f/WMJYLc
	 7/LaT+S+fVmfRxJGjt/Wx0EXbxl4bvWbq5s8R8SacmJSz3UjjphfrioxliaEUG2E4w
	 V4xmFnWmK6gS099vK015SS4VtVXuCk33h5yLlVktH3xqCFvbuUOlitme2/GXfYG7uf
	 gc2FcxJPgO+aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09BB2811C1;
	Thu, 22 Oct 2026 21:34:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 526743AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4425C40556
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMqFIouiAJOb for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AC1D40539
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704866;
 b=H+I5OwEVm8OBp/4shHOQefu7rwHcKmL/nVi1v10wpl9WGFiaNEt0OgGXnV/uI1GMDdBI
 tG31cH+L6jranQ2kb3QXSXzSsrDgXihvV7TVSGjysqVZca8YOtbOHp7b6zztYaP0DWkX0
 z5JoD7Qnkw6jiNV01kRaDxP3ZCEydBYbVRJx7oOt9YNdVmJgmNXvDeQEQK21eBE7aX+MO
 3k7Mdl8p7OjJvrfqIgdWretfvNYQfF1Ti5YCT/jAc8eXkerFjBy/zbKvgHri1dWnmzqPz
 DxYkdSv6zocF+X4ym+rL1tFI6cFapFVryxW0miEGmdoFHXKsjOrFsnfwrAj9BMVemDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704866;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=;
 b=sBLBPj+aeTBi+OKwvxZx5y2UNGA+ybXmOd3Aei6CRXZCSkSgTIJJruTJAIVmfUi/EyL4
 UvgX/quIPh18HlAl7ZfPg2ISsnqD9QCEyVElf258v2uEFQYLOlTht+Dfn4db+tiXC6RmF
 MFyqHVefcNzi/lV9hL2M9Y1yUaXMj20vqkqdTZ62qcPpLyWnAlDA30Lc/p2ZytsxZk5UD
 57CyFdF8vcUVmS56hqTC/r+x/873ZL1ZivZx3JqO+gshCQzohLGs+/2uynwg2yfGEfJgc
 WpH9wMzblncfX71hdOXrCaqUPUaK7oY9f4RubiB4WuYOvg4lynpe0C63224oOlPKZjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SCfiWglV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U6Vm2cR8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SCfiWglV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U6Vm2cR8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AC1D40539
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWmh93413272
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=; b=SCfiWglVTtXbgG9G
 knFHxjB8yjKt4sKG3WpRk+Bb8YN/enxBXfHn+ZwOri0TcuaHUjbOVMS0NX0qdh0/
 OxWo3CbYhHUGHrYfewjdYLgtEC1bPguQ0kXlgup3fueVB6KTRSCSL4xyNj9Cj560
 GiAMeGl4sivS/mlYWQqENXUOOrSXhTcxVYwVOUlKo0EXICCvK/ayZir/MK91uU+r
 IRYNG1C/mr++PUqtQPo9gTFB0axotHM8JIcvtLq7FUfHv2qKnk1eg1fnc2/VZ82o
 Eus1r4VF6zDoVN5vHeJG4iBJt1eCeF8QzFxnWfWO92R5spUoAgiq8hWMkLSj1/uj
 5yNMZg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar622-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:25 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-869553205a7so5287647b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704865; x=1793309665;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=;
 b=U6Vm2cR8kddQdmWoxqu5mf39iH5Kv6nw7KRNv1SVWzC77oeorDKhrMX3P0mWEOAnF1
 ZPj/GTdeCTaJv11C0Q5ZJSEZwhNd9wSjeyTx+o2+Hpr/XQYzyYEVXmEb3fbVKU03ePJI
 nsbCEt7LjwLTVggtLLUwjracRJmXErV8IckPsXot1oTrc9CQgez2dWrsQTGsCe1Chwpq
 X1M6PTngpV+AD/rUeTKNQhxazehDjmoLbSmQDLcRkVUtIfWJXIDPVwGg7kgaDBeCiw2w
 lDuun5zsIRZh6QKVIZe4cKOHSvdd1vwS1rjdiT+Qczvbo+5v0LCyAOZPhN+aiLL5QiP1
 TcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704865; x=1793309665;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JfqzIzS8TIz8ZM9qCyjYYLpQymeYJGb6+hk2wPBPmrM=;
 b=UDcRXUX+brcV8DPHjpYa5Pt2JsjeafLNSI8GS4yBP3BNE0j8Iqt4+seGP84QZBoZSc
 bSUgb0oVyysLvrBCPsqazKbF4mQa+gQTmZ9ASSfoqmwLxtbLkMrCN5szicmSaGhafUZn
 Gz/F9W9IfPdM/Z8xi3IUmpYYIJIxeY4/LZz3vr9ronX0RXyulrqU0e4QiriDh3YgD0ZW
 i4/qLhst536OAF5Jvn1BhzWHqYbdYz8iiB1UNydOisvwoLHP0bnYfcbhHOXaSNJND0T7
 FTJAvoO1CD9rH/9K8c1kazHKd+vHvcHJTOEvVOWSrFnV6RAJ+DrsehNbl10RzQimlUuG
 LAjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx+mW0Jx7WhZWDTJZK8q0vdghB4NA6enqCGcxQlyd+8JsrNF2Qm4XvKOvdR2JGyHp4rp0QlXs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLqgu/GJR/1rw+ffQuUitANDguTr1MYhDrsGoLJBhDGT76oNI1H
 RvdxuGFhTv2mWoqBHOYe6xts8buvMBS73Qfd6qZ+02uaBaoVJuTiHmHagm2TU8+EJT+xU9vFFXY
 z/4lxxxBaTi6aafSnvPfOh1ASHdvQcM1+zKbJRi0IGwHp/Xdix0gN1Lcd5rM9HYitfDogAdM=
X-Gm-Gg: AYBFou1v7b073N1VtsEPNFzCtNlYMQdacBODguXg8tP6emsoPIueBu1TrCMJ+E2LbqX
 CYZtpn4LTzgeduTuihF2QEkm3Eeap1mKXFiloFBUfP7Zl83rOnMqYA6qzzHyHIxgqm/XJfdf/JN
 wrnPfihvjGDaZiBW3MnPSH2fKOi5v8JwUsnOHZSw0v29hwyIt4a7+Z/XsQ6KHsbYztBuLLXiZU+
 pbVKUwpmsSubH4mLllhFNnN8l5YbP2fuk/VYDk/doZ4gb13WjtWKEAPy9K1p2IRw4H3P+tNByzc
 hrnhQpzrzpP8rbYGY4MaQU06DLgNDTRVlYyrVrgpJTO38GEfu0a1u2HV6H/CyqkrhznV7iVKLUh
 gZmEgG0Ze9zO7SQqHN1PkThFTrKWlha4m+9AHj6k9vBVlqyV+fjDbqYBKV4yz
X-Received: by 2002:a05:690c:e3e5:b0:8b0:f04a:3130 with SMTP id
 00721157ae682-8b157e35c82mr2979457b3.41.1792704864815; 
 Thu, 22 Oct 2026 14:34:24 -0700 (PDT)
X-Received: by 2002:a05:690c:e3e5:b0:8b0:f04a:3130 with SMTP id
 00721157ae682-8b157e35c82mr2979047b3.41.1792704864228; 
 Thu, 22 Oct 2026 14:34:24 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b156167d89sm4282077b3.32.2026.10.22.14.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:23 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 3/8] clk: qcom: add SEGCC driver for nord
Date: Thu, 22 Oct 2026 17:34:15 -0400
Message-ID: <20261022213415.765835-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-4-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-4-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada8161 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=j1v-TrxYBxJZrgiPmxAA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfXz7x6dV06Rfi+
 ikFHcQaByM8Q4EOLvUoct9qgvA84yKshd2gR2tjkUViPUolompEm857exq63iO3BDATY3wAGkws
 vPccNk/QvTWBVb0WtslaK5+M0+D1GuI=
X-Proofpoint-GUID: -1WZIzJUGRPq8ESeNz4w-0yC7GMqgGYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX+DAfLjtSB/r4
 /cI12oUoNb+kKQ5IdhV6ZMEpE1u0OB9d8pAXOxoA3jzyzWUKqh64Y6JhL9liEG8GznnOFzVrQfG
 3fmsp/H///lhGfG2+8ZUOSR8HCtcilahx+jibY9vpfoeyMz+2LFQgz4Bz12bXS5Nbh2Eib5PXiT
 Bf3Ahb2tlJ+4cDcPiZ454+igJWwnBdLWi+VWbNus8fcoxqA6neRWTuCjHjFywUURsNdA0yRLNC4
 XLUAepu/G3iL4zyIQZPezKOTMQhOjSJ4x/buJ6UZrFdm4KvhYm1EO9CgS7R/F29KI53LE1z1JmM
 +JBSOBvza6z3f8VmK0s12r4BuDBjEXMq8rvp5EHd3lo+aqqV6CW8lRRbz7kZ52vnVHbGgqaoRK0
 2CHBYqPfNA95UwMPavm3kqdqR22oeuHH+kFPs3UceM3FcVVXHyNpYjIlpqOrJ5pLF+lQfEgpE48
 e83TpF9DXfq1ehHBjyg==
X-Proofpoint-ORIG-GUID: -1WZIzJUGRPq8ESeNz4w-0yC7GMqgGYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220085
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
[...]
> +		WARN(rate != 14745600,
> +		     "Unexpected rate for SE_GCC_QUPV3_WRAP0_S4_CLK: %lu\n", rate);

Same UART rate bug as negcc, and 23 CBCR-backed gates use GATE_CLK.

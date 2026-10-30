Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF90606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VVrfPIwO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W0q+CQl9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4c69fU9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1296A81117;
	Fri, 30 Oct 2026 12:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYi2PthLhCw2; Fri, 30 Oct 2026 12:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E85FC81112
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362864;
	b=kNIeEGeeK12JfBBZzswi/7Lk02CV+s2SqYuGEV4ZV1QGrL48sDdpBhtl2MgMs6XhxvjX
	 qX9KuNRNiJATTEm8RbYZrzHSw3/xtHKtTXjIJmVtT5Yhnf9BJ+cfE3X2y18GGf50tsMYp
	 6Ln4/5hUn3NZxRUtq1GSnMHL+jzDZJ1LtT1t6VQBu6ncfZs6USfImkPtwZ4/U//7oxGgy
	 bKiJrNCJd3XgDG+zS+M5th2+aq04wqBm3QrqgMqZUUMXZcfi6g7SwlXAvpzYF0nph4wRj
	 n9IqeRYZY3f2XY5toLtyrCp0VnDW2K/zVeKtleg5mZ2wORk7pQPMnZQAWOpJ4OAssvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793362864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
	b=BsvUd1ykOHnq3fl1whWDnMgFqpOMfCEjBUounuv+QtlKF441SbyiVAA7vXCB2dBQTMCk
	 VrxCC6PiwqbpE/dbG/PX43kS7klYzxxHAvYfcBIjCd6+17fW9t31SZfL8/4bPhUNOQtfW
	 qaU3JYumllHQUfS8pzmpxjwe/E0MfZTKgbCPFmz9mrS7A3NolN/QuEHhcfd0DZAmMG3pB
	 vhG6qlHB1gg9VvAktGyS0/Haq0D01oQwcM/Y/hV0k2JxPnbrCmdH1/hrivUhhxacpyr2Y
	 CM7pkBYA8zm7tQhcAwC1T5hLFJwkTrG55mP2mWwk4hnwKw3pP2e+83tUu+KIsK+vmCA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W0q+CQl9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4c69fU9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793362864;
	bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVrfPIwOm6FdbhUalnLawKyELBZ3LjnGLV2ivOArKbLFTPYNmtVDZ7RDTYH0cQW5R
	 XAkQ+zc3UTKiTjrMgQApXzF6XzRCIjUUqaF6F96OCPWCm5lo0mCMPdiRZtGu7ve56Q
	 2FCf1XEkoDdAMRhNuMNVpFYAhfwuiMHQgIQZYONII3s2hOLdmq1v7C5BtF5BpZMj5N
	 l6EFcplXYPHJfGka5MkPG3jm00eQfzIxFEaHGKTQY5edohjKAmO0Yy8MRMpv1MERc/
	 +PQs5dhqwY4YfUb/QmeTZEaQEMjMHoI7mwfYUk+yAyhZPhEsAVmmTFp+DiEMgIUShF
	 L7unHoa2DbEjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E85FC81112;
	Fri, 30 Oct 2026 12:21:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 525AD362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36CF181112
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bbfa8EoqkRyj for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:21:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0624E8110C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362860;
 b=oGJqkQaJxGabDFx3fGpOZVzlqNRjapPE0P7jJbWXSzrNhS6sHZqHEez4zBTgAlnpmJ6O
 w21MWtDnohmWdxWNfjTltalUo5eSWNBQLFACjh3x8L0FBbsdDmF5Kxt7a/HVah/uSxdo7
 5fvHigpES9n+n/onJggo8/EDxLJvwTo1YQtpkYilY2uTY4IBJ5pzIQmCOatrv2XLCTmG3
 Ef8Jg4tEPoXkhESzwaNuIanHDTT9pYSg9JFP3qJdug84H58K+faGHcUb5PQfJy6CPxtuO
 l8bLoJQS8F/zUeCX+uiAnEE8r+y6qGnyqUWjywyaGx+CSxGlgWEjF5FIVlOI9ywAmtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793362860;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
 b=g3+Lzt8uSVRVGp2zpbFlIiIcaBFB+4skm/8NVJ0FD0r5fFeYbhAukdLY1Vz/kFNWWuRY
 N/szpOzYhuz86NwsLcdXU9oDzws8LsryNF3GI/yDPyo1Z97HpjDpV2wYFvRNNSw/kBOVg
 FG9OGnTfphKm8foLrx/Jb67e8LzgXzcGUAXcFPISvCvj4sty6QtVAHh70/U5JBxaujMe9
 o7Dtt2SEP0bRtU+CGapLE20ZdnyPNjzrAzA/lcOJbos+eQ6CAaC0Cci7fewgnsCQKG/PV
 lG8WoQCMMZYIED32fR8QOKvDfK7sFCRCQVe9hTP3D9TQ9sbngpkBktGsTvNetmcoa+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=W0q+CQl9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J4c69fU9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=W0q+CQl9; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J4c69fU9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0624E8110C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:20:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBFxb83089201
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=; b=W0q+CQl9gk9tYQFw
 i1NjAAFmbN6gfEIxpNY93s5EBVpLXiap5Qbs8bq0HLfXlRFZ9ex0X0TTEYsdFuaV
 kXwV2viOuxJU3gI+rLiQDbecAd+f2xBwq4NHPJPrKq/1z4fOVE0KrCMjayWEMXXH
 SbH31ghwWdy4oLy1fvskO7JgqsHmxUavM5AzgWSFY3NVHGDmIuSi2jDFtYn1LsMC
 FedFODjs+mYda3axJGJbwTM4ocC1NtNAD5+ekl4rCb3CV0K0SWK+YK98vbMiWxR2
 KrfDcEtKhtYU704jwLK5pWU1zBY8loV/RbeLCphrtXWd4ufD9jz1E9eOGb2wdCKP
 bYaCyQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk0nd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:20:58 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6798c43a3bfso1066294d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362857; cv=none;
 d=google.com; s=arc-20260327;
 b=mDPD81ycKX1Q9gfB39mndVlRDWmSJaoE011gMJ30He6kCvaxJIfm78qNC/51cZIYLk
 QkMj8zPtK/o4KZnUpd3kvH100LeElMA19P9Iu3mXVLRDvGDr3CMiA/erUwU3H8HSs2i2
 YUCZmH4U5U1wIXplLXlDPFkL89eWmb4IbP7s+lKIjupAuEY9IcnxEICgZN973fXlW8nN
 s775bK4kQqC10pqsQ3yjiF5sdn234WLjvx93BTChC9SiVk+ItQd6Oy+fJUKQN3KDkjKv
 i8OQKdjfcZOMzaq00Xa5DV95p75D4jmC/LVaaNyZUEOjtoKUhff3SPcjZKRBJxKnaZ6H
 3GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
 fh=5X9eZ+/Z7TV9t56ri/xWKMBjhGPLdF7/kauXFcJYoPM=;
 b=ppqP4sQAdhqNu3uNAt/TQVGVLsly2eHOWQEAiJDSuL9q4Ixv8IYqf2M5zCCBg0vbDk
 Ndb3Z4MO4BSQ6BhbAMxMMW8SO7O2bVcVZWXeXu++N2IjsVyuSaGmeBObDUi669YTBnF4
 DNmLfz71jbdIw0fN0F0cxyk9cgZCfMAoz/M6WeuehayRCANjwbZI2MDVNzf6iPMkCE3e
 M4YdFnmujS97O09xMrQHZdXR6dpLhmIYvB9XMi5/fovOhDOwoxPlidSLfid1AgWEqi0O
 poK1i8kgguJoBeN0Ed6TQK2cuMKfzgNmxs8BabRH+ZX4GBzRln0AEF7CifhTlY6hYTSv
 4VbQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793362857; x=1793967657;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
 b=J4c69fU9hBYINSYSsW7dPTeYMgnDNVY7m7Z4uuV95rUDn5yIR75mKH2dJCM087ywle
 y6Xv2R9nvd78L1s5yN10CejfJ0wvy62M40p7M6e1w9k6W++SYNxpX+L6h8vP1xH2FY1g
 0cz8gbhcmq3KAzcpXvTfLFnLe+xY8EO84jd2URuGSOSmQT9DMcQB3zp5gfxYzwKH5K/U
 mndE+CcyAnEzI26H3HxVsmDZoq/Peca2dtmiGhJCd32JoiPyQ00LlXd2TnS8yfFmlLud
 9ntm9SLGzufVesi6v9yrdRzNr1HuBuevO0u6ByaVzU4ZTQdc8OrGdezfMus+OE54CULQ
 zCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793362857; x=1793967657;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xnCFzz9WRA8d2ZlI3WzFn+bFSx2fEH80u6ZdK/IPVRo=;
 b=W1Y9H4OnzHbJME0Zi7zZUVVHImIpjrpiHrzKoDGlrlFf2YIZcFL2L4oSZekPcXWqFZ
 InFHJtMnswEQgbPoGZhf1rqlnZbeqj2PIOb/6IkcendJyhACuWyV6q+JfCL/UC3q0gqV
 gdouIyw+Mj4EJPpzJSbRjn6QBctQ25A/ZcypMElLMGAGGc1uXxPFde/EeV3QYGtWE9M7
 Vv3zaEdsrjfs+wGfeyjW9la2mXRs9fRN/ZGq3/cxV0l4qqpEbH0OF/zRe8Z+U3TH4lwZ
 EnEZjU7vBSWEX3VU0lXaVNs7t0aOj9NFeVP8tHlCwZoEbUK6dscHIpiYYRkmhzWes4HA
 PY1w==
X-Forwarded-Encrypted: i=1;
 AKwUvByOV/mk/q3yc9uXBxcX4F/H/sOLXFEkbZGvDHbwNkA9ppttUohgIzslFDChiE7yJ04eoI3jDao=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIxvNkog55Ja9KJ/ZL2fPrDvnbG1FHK9cidLBBe4Fap7fLR79z7
 gRUFzz18vBG+m7Au1a9R8DfnMn+g70/yPBK2ugdlFWq/tMuHbAbZuqK3AO19sk13Dwrz8LzPaNh
 4YVd45IdDq7tIbnBbac+ea91mMQZ8Gl93cQhq/3pl4LQaIscCnbiU/ch0tV5FJPXku+iFHGrdQY
 2xbZBief7mfNRjfpWEjVv+2f73zMQbiealnHk0jFNrrmD65A==
X-Gm-Gg: AYBFou1+wKxfitvjdYaABL2iiKB42h1+nr1a9kx7J5z1y1GvRDbBRKrTioGowc5fIkP
 7Vct1RH/+Xrwdbj3O/Iv8feArbYZ16OuYWM7triw+01Z3ikvpue37EcNvIvlzkkokMNMsw/yRiY
 vdbTTzJc1VyLXY/Qi33QKCws4Tzt1fqWIcDZ2aPrIzLJAzE4LgLrctOY8=
X-Received: by 2002:a05:690e:4594:20b0:679:a216:7ac7 with SMTP id
 956f58d0204a3-67ba5001b40mr787586d50.113.1793362856881; 
 Fri, 30 Oct 2026 05:20:56 -0700 (PDT)
X-Received: by 2002:a05:690e:4594:20b0:679:a216:7ac7 with SMTP id
 956f58d0204a3-67ba5001b40mr787572d50.113.1793362856222; Fri, 30 Oct 2026
 05:20:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
 <20260902170559.3225833-3-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260902170559.3225833-3-aswin.murugan@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:20:44 +0100
X-Gm-Features: AclHuK8O9MvhNoWrMY3f0l4dNQ5WoQczonGQbnA-K3QbfpNaaqxMB4cE6-gzT2I
Message-ID: <CAPzfCAatfvkY-72i4ZwbnepVb6z1DzwyAWSsa2-AimvxmBGbWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: msm_sdhci: add HS200/HS400 support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, nathbappai@gmail.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _ztTTVZmqj4HA9nIOOpNLHdUbqt440AK
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae48baa cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=qwtGhMrVFWDKOY0TZQ4A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfX1vbhsILixnrA
 CShbL5I/eszOAGcWwhVe0CpFkB9LGL0hQgIBVFt8pRN8c5LbbOgNTLhzNZCUuFyQvg5p9Ih4VI0
 kbdwhcrOumOqSG/Mf4dX7qcG6HQNt3foDTwFYVLjYk75ib9jfcEUl9lmDV++g9f6/fytq4coTbO
 1JyjEh32M7TNfguOO2EIUQJzk7JC1VAmvDmo0eY6rDUze3/ytemz/4xL0H0vrXLrZefQv8GbXc3
 dCTrABeGhegt3eUxVjAcbcDiJscrIZi1DXtASy41ACUFq8kz3cMr9iMpAggyTXaWGDAHMk41SS+
 mb4rQNFe8AKLBH/2QU/t4q7rnL4S7891MGUlRD3W+e77KajbuOpCcvnizryweN6W27YpDVPO9h1
 aE53kg2GrjVvt53P6ss8A2cECCOOXIER4QuDJUGgY/8QmeP0+iqKna/HF/su2ZaE4fhXa+6zK6M
 D7odTFfwEZVKrcPFEkQ==
X-Proofpoint-ORIG-GUID: _ztTTVZmqj4HA9nIOOpNLHdUbqt440AK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfXym21CyzEVzax
 jwf0iNhXZaacRY+QAdUFXN7bryqjATAXLHH1NnwfCip7E+GvMZhLA4vQzuykbhAWADWuLqNirw4
 ri7OdrIYXSJC/1g2bRxAz8yljtSwuvk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300049
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aswin,

On Wed, Sep 2, 2026 at 7:08=E2=80=AFPM Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
> support, so it never negotiated above high-speed/DDR52. Add the
> CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
> calibration for HS400, matching the SDCC core generation variants
> already distinguished in this driver.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Tested  on Agatti (Uno Q):

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 752 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 751 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index e0753a1cd5d..668aadf6c6e 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -15,7 +15,9 @@
>  #include <wait_bit.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <linux/iopoll.h>
>  #include <power/regulator.h>
> +#include <memalign.h>
>
>  /* Non-standard registers needed for SDHCI startup */
>  #define SDCC_MCI_POWER   0x0
> @@ -38,6 +40,52 @@
>  #define CORE_DLL_PDN           BIT(29)
>  #define CORE_DLL_RST           BIT(30)
>
> +/* DLL configuration */
> +#define CORE_DLL_EN            BIT(16)
> +#define CORE_CDR_EN            BIT(17)
> +#define CORE_CK_OUT_EN         BIT(18)
> +#define CORE_CDR_EXT_EN                BIT(19)
> +#define CORE_DLL_LOCK          BIT(7)
> +#define CORE_CMD_DAT_TRACK_SEL BIT(0)
> +
> +#define CDR_SELEXT_SHIFT       20
> +#define CDR_SELEXT_MASK                (0xf << CDR_SELEXT_SHIFT)
> +
> +/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to=
 lock */
> +#define CMUX_SHIFT_PHASE_SHIFT 24
> +#define CMUX_SHIFT_PHASE_MASK  (7 << CMUX_SHIFT_PHASE_SHIFT)
> +
> +/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >=3D 0x42 / 0x7=
1 */
> +#define CORE_DLL_CLOCK_DISABLE BIT(21)
> +
> +#define DLL_USR_CTL_POR_VAL    0x10800
> +#define ENABLE_DLL_LOCK_STATUS BIT(26)
> +#define FINE_TUNE_MODE_EN      BIT(27)
> +#define BIAS_OK_SIGNAL         BIT(29)
> +
> +#define DLL_CONFIG_3_LOW_FREQ_VAL      0x08
> +#define DLL_CONFIG_3_HIGH_FREQ_VAL     0x10
> +
> +#define CORE_CLK_PWRSAVE       BIT(1)
> +
> +/* Timing mode selection */
> +#define CORE_HC_MCLK_SEL_DFLT  (2 << 8)
> +#define CORE_HC_MCLK_SEL_HS400 (3 << 8)
> +#define CORE_HC_MCLK_SEL_MASK  (3 << 8)
> +#define CORE_HC_SELECT_IN_EN   BIT(18)
> +#define CORE_HC_SELECT_IN_HS400        (6 << 19)
> +#define CORE_HC_SELECT_IN_MASK (7 << 19)
> +
> +/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above=
 */
> +#define CORE_DDR_CAL_EN                BIT(0)
> +#define CORE_DDR_DLL_LOCK      BIT(11)
> +#define CORE_PWRSAVE_DLL       BIT(3)
> +#define CORE_CMDIN_RCLK_EN     BIT(1)
> +#define DDR_CONFIG_POR_VAL     0x80040873
> +
> +#define CORE_FREQ_100MHZ       (100 * 1000000)
> +#define MAX_PHASES             16
> +
>  #define MHZ(X) ((X) * 1000000UL)
>
>  struct msm_sdhc_plat {
> @@ -50,14 +98,39 @@ struct msm_sdhc {
>         void *base;
>         struct clk_bulk clks;
>         struct udevice *vqmmc;
> +
> +       /* HS200/HS400 tuning and calibration state */
> +       bool tuning_done;
> +       bool calibration_done;
> +       u8 saved_tuning_phase;
> +
> +       /* DLL init sequence variant selection, from the SDCC core versio=
n */
> +       u32 dll_config;         /* qcom,dll-config DT override, 0 if abse=
nt */
> +       bool use_14lpp_dll_reset;       /* core_minor >=3D 0x42 */
> +       bool uses_tassadar_dll;         /* core_minor >=3D 0x71 */
> +
> +       /* HS400 support */
> +       bool use_cdclp533;              /* core_minor < 0x34, legacy cali=
bration path */
> +       bool updated_ddr_cfg;           /* core_minor >=3D 0x49 */
> +       u32 ddr_config;                 /* qcom,ddr-config DT override, e=
lse POR value */
>  };
>
>  struct msm_sdhc_variant_info {
>         bool mci_removed;
>
>         u32 core_dll_config;
> +       u32 core_dll_status;
> +       u32 core_dll_config_2;
> +       u32 core_dll_config_3;
> +       u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
>         u32 core_vendor_spec;
>         u32 core_vendor_spec_capabilities0;
> +
> +       /* HS400 DDR/SDC4 calibration registers */
> +       u32 core_ddr_200_cfg;
> +       u32 core_vendor_spec3;
> +       u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; =
0 if N/A */
> +       u32 core_ddr_config;
>  };
>
>  static int msm_sdc_clk_init(struct udevice *dev)
> @@ -149,12 +222,624 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
>         return 0;
>  }
>
> +static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
> +{
> +       u32 ck_out_en;
> +       struct udevice *dev =3D host->mmc->dev;
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       int ret;
> +
> +       ret =3D read_poll_timeout(readl, ck_out_en,
> +                               (!!(ck_out_en & CORE_CK_OUT_EN) =3D=3D po=
ll),
> +                               1, 50,
> +                               host->ioaddr + var_info->core_dll_config)=
;
> +       if (ret) {
> +               printf("%s: CK_OUT_EN bit is not %d\n",
> +                      host->name, poll);
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
> +{
> +       int rc;
> +       static const u8 grey_coded_phase_table[] =3D {
> +               0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
> +               0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
> +       };
> +       u32 config;
> +       struct udevice *dev =3D host->mmc->dev;
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +
> +       if (phase > 0xf)
> +               return -EINVAL;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config &=3D ~(CORE_CDR_EN | CORE_CK_OUT_EN);
> +       config |=3D (CORE_CDR_EXT_EN | CORE_DLL_EN);
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       rc =3D msm_dll_poll_ck_out_en(host, 0);
> +       if (rc)
> +               return rc;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config &=3D ~CDR_SELEXT_MASK;
> +       config |=3D grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_CK_OUT_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       rc =3D msm_dll_poll_ck_out_en(host, 1);
> +       if (rc)
> +               return rc;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_CDR_EN;
> +       config &=3D ~CORE_CDR_EXT_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       return 0;
> +}
> +
> +/*
> + * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
> + * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
> + *
> + * host->clock is not updated by the generic sdhci.c, so mmc->clock is
> + * used instead.
> + */
> +static void msm_cm_dll_set_freq(struct sdhci_host *host)
> +{
> +       struct udevice *dev =3D host->mmc->dev;
> +       struct mmc *mmc =3D host->mmc;
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 mclk_freq =3D 0, config;
> +       unsigned int clock =3D mmc->clock;
> +
> +       if (clock <=3D 112000000)
> +               mclk_freq =3D 0;
> +       else if (clock <=3D 125000000)
> +               mclk_freq =3D 1;
> +       else if (clock <=3D 137000000)
> +               mclk_freq =3D 2;
> +       else if (clock <=3D 150000000)
> +               mclk_freq =3D 3;
> +       else if (clock <=3D 162000000)
> +               mclk_freq =3D 4;
> +       else if (clock <=3D 175000000)
> +               mclk_freq =3D 5;
> +       else if (clock <=3D 187000000)
> +               mclk_freq =3D 6;
> +       else if (clock <=3D 200000000)
> +               mclk_freq =3D 7;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config &=3D ~CMUX_SHIFT_PHASE_MASK;
> +       config |=3D mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +}
> +
> +static int msm_dll_poll_lock_status(struct sdhci_host *host)
> +{
> +       u32 dll_status;
> +       struct udevice *dev =3D host->mmc->dev;
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       int ret;
> +
> +       ret =3D read_poll_timeout(readl, dll_status,
> +                               (dll_status & CORE_DLL_LOCK),
> +                               1, 50,
> +                               host->ioaddr + var_info->core_dll_status)=
;
> +       if (ret) {
> +               printf("%s: DLL failed to LOCK (DLL_STATUS=3D0x%08x)\n",
> +                      host->name,
> +                      readl(host->ioaddr + var_info->core_dll_status));
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +/* CM_DLL initialization sequence */
> +static int msm_init_cm_dll(struct sdhci_host *host)
> +{
> +       struct udevice *dev =3D host->mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 config;
> +       int ret;
> +
> +       /*
> +        * Keep the clock enabled while DLL tuning is in progress; PWRSAV=
E
> +        * may otherwise turn it off.
> +        */
> +       config =3D readl(host->ioaddr + var_info->core_vendor_spec);
> +       config &=3D ~CORE_CLK_PWRSAVE;
> +       writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +       if (priv->dll_config)
> +               writel(priv->dll_config, host->ioaddr + var_info->core_dl=
l_config);
> +
> +       if (priv->use_14lpp_dll_reset) {
> +               config =3D readl(host->ioaddr + var_info->core_dll_config=
);
> +               config &=3D ~CORE_CK_OUT_EN;
> +               writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +               if (var_info->core_dll_config_2) {
> +                       config =3D readl(host->ioaddr + var_info->core_dl=
l_config_2);
> +                       config |=3D CORE_DLL_CLOCK_DISABLE;
> +                       writel(config, host->ioaddr + var_info->core_dll_=
config_2);
> +               }
> +       }
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_DLL_RST;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_DLL_PDN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       /*
> +        * MCLK_FREQ must be programmed while the DLL is reset and powere=
d
> +        * down, unless a DT dll-config override is in effect.
> +        */
> +       if (!priv->dll_config)
> +               msm_cm_dll_set_freq(host);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config &=3D ~CORE_DLL_RST;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config &=3D ~CORE_DLL_PDN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       if (priv->use_14lpp_dll_reset) {
> +               if (!priv->dll_config)
> +                       msm_cm_dll_set_freq(host);
> +
> +               if (var_info->core_dll_config_2) {
> +                       config =3D readl(host->ioaddr + var_info->core_dl=
l_config_2);
> +                       config &=3D ~CORE_DLL_CLOCK_DISABLE;
> +                       writel(config, host->ioaddr + var_info->core_dll_=
config_2);
> +               }
> +       }
> +
> +       /* Applicable to SDCC v5.1 onwards only */
> +       if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
> +               config =3D DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
> +                        ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
> +               writel(config, host->ioaddr + var_info->core_dll_usr_ctl)=
;
> +
> +               if (var_info->core_dll_config_3) {
> +                       config =3D readl(host->ioaddr + var_info->core_dl=
l_config_3);
> +                       config &=3D ~0xFF;
> +                       if (host->mmc->clock < 150000000)
> +                               config |=3D DLL_CONFIG_3_LOW_FREQ_VAL;
> +                       else
> +                               config |=3D DLL_CONFIG_3_HIGH_FREQ_VAL;
> +                       writel(config, host->ioaddr + var_info->core_dll_=
config_3);
> +               }
> +       }
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_DLL_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_CK_OUT_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       ret =3D msm_dll_poll_lock_status(host);
> +       if (ret)
> +               return ret;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_CDR_EN;
> +       config &=3D ~CORE_CDR_EXT_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       priv->calibration_done =3D false;
> +
> +       return 0;
> +}
> +
> +/*
> + * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is fals=
e
> + * (core_minor >=3D 0x34).
> + */
> +static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
> +{
> +       struct udevice *dev =3D host->mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 config, ddr_cfg_offset, wait_cnt;
> +       int ret;
> +
> +       /*
> +        * core_ddr_config defaults to the desired configuration on reset=
;
> +        * reprogram the POR value in case an earlier bootloader stage
> +        * modified it.
> +        */
> +       if (priv->updated_ddr_cfg)
> +               ddr_cfg_offset =3D var_info->core_ddr_config;
> +       else
> +               ddr_cfg_offset =3D var_info->core_ddr_config_old;
> +       writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
> +
> +       config =3D readl(host->ioaddr + var_info->core_ddr_200_cfg);
> +       config &=3D ~CORE_CMDIN_RCLK_EN;
> +       writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config_2);
> +       config |=3D CORE_DDR_CAL_EN;
> +       writel(config, host->ioaddr + var_info->core_dll_config_2);
> +
> +       ret =3D -ETIMEDOUT;
> +       wait_cnt =3D 100;
> +       while (wait_cnt--) {
> +               if (readl(host->ioaddr + var_info->core_dll_status) &
> +                   CORE_DDR_DLL_LOCK) {
> +                       ret =3D 0;
> +                       break;
> +               }
> +               udelay(10);
> +       }
> +
> +       if (ret) {
> +               printf("%s: CM_DLL_SDC4 calibration was not completed\n",
> +                      host->name);
> +               return ret;
> +       }
> +
> +       /*
> +        * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cann=
ot
> +        * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
> +        */
> +       if (!priv->use_14lpp_dll_reset) {
> +               config =3D readl(host->ioaddr + var_info->core_vendor_spe=
c3);
> +               config |=3D CORE_PWRSAVE_DLL;
> +               writel(config, host->ioaddr + var_info->core_vendor_spec3=
);
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * HS400 DLL calibration, performed once when transitioning into HS400 a=
t
> + * clock > 100MHz.
> + */
> +static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
> +{
> +       struct udevice *dev =3D host->mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 config;
> +       int ret;
> +
> +       ret =3D msm_init_cm_dll(host);
> +       if (ret)
> +               return ret;
> +
> +       /* Restore the phase found during HS200 tuning */
> +       ret =3D msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
> +       if (ret)
> +               return ret;
> +
> +       config =3D readl(host->ioaddr + var_info->core_dll_config);
> +       config |=3D CORE_CMD_DAT_TRACK_SEL;
> +       writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +       /*
> +        * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); =
our
> +        * supported targets always use the SDC4 calibration path.
> +        */
> +       if (priv->use_cdclp533) {
> +               printf("%s: CDCLP533 HS400 calibration path is not implem=
ented\n",
> +                      host->name);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return sdhci_msm_cm_dll_sdc4_calibration(host);
> +}
> +
> +static int msm_find_most_appropriate_phase(struct sdhci_host *host,
> +                                          u8 *phase_table,
> +                                          u8 total_phases)
> +{
> +       int ret;
> +       u8 ranges[MAX_PHASES][MAX_PHASES] =3D { {0}, {0} };
> +       u8 phases_per_row[MAX_PHASES] =3D { 0 };
> +       int row_index =3D 0, col_index =3D 0, selected_row_index =3D 0;
> +       int i, longest_range_len =3D 0;
> +       bool found =3D false;
> +
> +       if (!total_phases || total_phases > MAX_PHASES) {
> +               printf("%s: Invalid argument: total_phases=3D%d\n",
> +                      host->name, total_phases);
> +               return -EINVAL;
> +       }
> +
> +       for (i =3D 0; i < total_phases; i++) {
> +               ranges[row_index][col_index] =3D phase_table[i];
> +               phases_per_row[row_index] +=3D 1;
> +               col_index++;
> +
> +               if ((i + 1) =3D=3D total_phases)
> +                       continue;
> +
> +               if (phase_table[i] + 1 !=3D phase_table[i + 1]) {
> +                       row_index++;
> +                       col_index =3D 0;
> +               }
> +       }
> +
> +       if (row_index =3D=3D 0) {
> +               ret =3D phase_table[total_phases / 2];
> +               goto exit;
> +       }
> +
> +       for (i =3D 0; i <=3D row_index; i++) {
> +               if (phases_per_row[i] > longest_range_len) {
> +                       longest_range_len =3D phases_per_row[i];
> +                       selected_row_index =3D i;
> +                       found =3D true;
> +               }
> +       }
> +
> +       if (found) {
> +               ret =3D ranges[selected_row_index][longest_range_len / 2]=
;
> +       } else {
> +               ret =3D -EIO;
> +               printf("%s: Failed to find a valid phase\n", host->name);
> +       }
> +
> +exit:
> +       return ret;
> +}
> +
> +static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
> +{
> +       struct mmc *mmc =3D host->mmc;
> +
> +       return mmc->selected_mode =3D=3D MMC_HS_200;
> +}
> +
> +static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
> +{
> +       struct sdhci_host *host =3D mmc->priv;
> +       int tuning_seq_cnt =3D 10;
> +       u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt =3D 0;
> +       int rc;
> +       struct udevice *dev =3D mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +
> +       if (!sdhci_msm_is_tuning_needed(host))
> +               return 0;
> +
> +       /*
> +        * The SDHCI core may call execute_tuning before host->clock is
> +        * updated to match mmc->clock.
> +        */
> +       if (host->clock !=3D mmc->clock) {
> +               rc =3D sdhci_set_clock(mmc, mmc->clock);
> +               if (rc) {
> +                       printf("%s: Failed to set clock for tuning\n", ho=
st->name);
> +                       return rc;
> +               }
> +       }
> +
> +       priv->tuning_done =3D false;
> +
> +retry:
> +       rc =3D msm_init_cm_dll(host);
> +       if (rc) {
> +               printf("%s: Failed to init DLL\n", host->name);
> +               return rc;
> +       }
> +
> +       phase =3D 0;
> +       tuned_phase_cnt =3D 0;
> +
> +       do {
> +               rc =3D msm_config_cm_dll_phase(host, phase);
> +               if (rc) {
> +                       printf("%s: Failed to set DLL phase %d\n",
> +                              host->name, phase);
> +                       return rc;
> +               }
> +
> +               rc =3D mmc_send_tuning(mmc, opcode);
> +               if (!rc)
> +                       tuned_phases[tuned_phase_cnt++] =3D phase;
> +       } while (++phase < MAX_PHASES);
> +
> +       if (tuned_phase_cnt) {
> +               if (tuned_phase_cnt =3D=3D MAX_PHASES) {
> +                       /*
> +                        * All phases valid is close to as bad as none va=
lid:
> +                        * likely no phase is really reliable. Retry a fe=
w
> +                        * times rather than guessing.
> +                        */
> +                       if (--tuning_seq_cnt) {
> +                               tuned_phase_cnt =3D 0;
> +                               goto retry;
> +                       }
> +               }
> +
> +               rc =3D msm_find_most_appropriate_phase(host, tuned_phases=
,
> +                                                    tuned_phase_cnt);
> +               if (rc < 0) {
> +                       printf("%s: Failed to find appropriate phase\n",
> +                              host->name);
> +                       return rc;
> +               }
> +               phase =3D rc;
> +
> +               rc =3D msm_config_cm_dll_phase(host, phase);
> +               if (rc) {
> +                       printf("%s: Failed to set final phase %d\n",
> +                              host->name, phase);
> +                       return rc;
> +               }
> +
> +               priv->saved_tuning_phase =3D phase;
> +       } else {
> +               if (--tuning_seq_cnt)
> +                       goto retry;
> +               printf("%s: No tuning point found\n", host->name);
> +               rc =3D -EIO;
> +       }
> +
> +       if (!rc)
> +               priv->tuning_done =3D true;
> +
> +       return rc;
> +}
> +
> +/*
> + * Configure HC mode selection. On the first HS400 transition,
> + * calibration_done is still false, so the HS400 mux-select bits are
> + * deferred until calibration completes in msm_sdhci_config_dll(); see
> + * sdhci_msm_hs400_select_in().
> + */
> +static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
> +{
> +       struct mmc *mmc =3D host->mmc;
> +       struct udevice *dev =3D mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       bool is_hs400 =3D mmc->selected_mode =3D=3D MMC_HS_400;
> +       u32 config;
> +
> +       config =3D readl(host->ioaddr + var_info->core_vendor_spec);
> +       config &=3D ~CORE_HC_MCLK_SEL_MASK;
> +
> +       if (mmc->selected_mode =3D=3D MMC_HS_200)
> +               config |=3D CORE_HC_MCLK_SEL_DFLT;
> +       else if (is_hs400)
> +               config |=3D CORE_HC_MCLK_SEL_HS400;
> +       else
> +               config |=3D CORE_HC_MCLK_SEL_DFLT;
> +
> +       writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +       if (is_hs400) {
> +               if (priv->calibration_done) {
> +                       config =3D readl(host->ioaddr + var_info->core_ve=
ndor_spec);
> +                       config |=3D CORE_HC_SELECT_IN_HS400;
> +                       config |=3D CORE_HC_SELECT_IN_EN;
> +                       writel(config, host->ioaddr + var_info->core_vend=
or_spec);
> +               }
> +       } else {
> +               /*
> +                * Clear these bits for every non-HS400 mode so a previou=
s
> +                * HS400 attempt never leaves them stuck set.
> +                */
> +               if (!priv->use_cdclp533) {
> +                       config =3D readl(host->ioaddr + var_info->core_ve=
ndor_spec3);
> +                       config &=3D ~CORE_PWRSAVE_DLL;
> +                       writel(config, host->ioaddr + var_info->core_vend=
or_spec3);
> +               }
> +
> +               config =3D readl(host->ioaddr + var_info->core_vendor_spe=
c);
> +               config &=3D ~CORE_HC_SELECT_IN_EN;
> +               config &=3D ~CORE_HC_SELECT_IN_MASK;
> +               writel(config, host->ioaddr + var_info->core_vendor_spec)=
;
> +       }
> +}
> +
> +/*
> + * Selects HS400 in the HC_SELECT_IN mux. Must only be called after
> + * sdhci_msm_hs400_dll_calibration() succeeds.
> + */
> +static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
> +{
> +       struct udevice *dev =3D host->mmc->dev;
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 config;
> +
> +       config =3D readl(host->ioaddr + var_info->core_vendor_spec);
> +       config |=3D CORE_HC_SELECT_IN_HS400;
> +       config |=3D CORE_HC_SELECT_IN_EN;
> +       writel(config, host->ioaddr + var_info->core_vendor_spec);
> +}
> +
> +static void sdhci_msm_set_control_reg(struct sdhci_host *host)
> +{
> +       struct mmc *mmc =3D host->mmc;
> +       struct udevice *dev =3D mmc->dev;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
> +       const struct msm_sdhc_variant_info *var_info =3D
> +               (void *)dev_get_driver_data(dev);
> +       u32 config;
> +
> +       /*
> +        * This controller has no HOST_CONTROL2 encoding for HS400. Keep =
the
> +        * UHS field at SDR104 (same as HS200) for HS400 too; the data pa=
th
> +        * is switched to HS400 timing via the vendor-specific
> +        * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits instead.
> +        */
> +       sdhci_set_voltage(host);
> +       if (mmc->selected_mode =3D=3D MMC_HS_400) {
> +               u32 ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +               ctrl2 &=3D ~SDHCI_CTRL_UHS_MASK;
> +               ctrl2 |=3D SDHCI_CTRL_UHS_SDR104;
> +               sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +       } else {
> +               sdhci_set_uhs_timing(host);
> +       }
> +
> +       sdhci_msm_hc_select_mode(host);
> +
> +       /*
> +        * Below 100MHz the feedback clock must be provided without the D=
LL,
> +        * so tuning can be skipped.
> +        */
> +       if (mmc->clock && mmc->clock <=3D CORE_FREQ_100MHZ) {
> +               if (mmc->selected_mode =3D=3D MMC_HS_200 ||
> +                   mmc->selected_mode =3D=3D MMC_HS_400) {
> +                       config =3D readl(host->ioaddr + var_info->core_dl=
l_config);
> +                       config |=3D CORE_DLL_RST;
> +                       writel(config, host->ioaddr + var_info->core_dll_=
config);
> +
> +                       config =3D readl(host->ioaddr + var_info->core_dl=
l_config);
> +                       config |=3D CORE_DLL_PDN;
> +                       writel(config, host->ioaddr + var_info->core_dll_=
config);
> +
> +                       /* Calibration must be redone once the clock retu=
rns to HS400 speed. */
> +                       priv->calibration_done =3D false;
> +               }
> +       }
> +}
> +
>  static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool=
 enable)
>  {
>         struct udevice *dev =3D mmc_to_dev(host->mmc);
> +       struct mmc *mmc =3D host->mmc;
> +       struct msm_sdhc *priv =3D dev_get_priv(dev);
>         const struct msm_sdhc_variant_info *var_info =3D (void *)dev_get_=
driver_data(dev);
>         u32 config;
>
> +       if (clock =3D=3D 0)
> +               return 0;
> +
>         if (enable && clock < MHZ(100)) {
>                 /*
>                  * DLL is not required for clock <=3D 100MHz
> @@ -169,12 +854,33 @@ static int msm_sdhci_config_dll(struct sdhci_host *=
host, u32 clock, bool enable)
>                 writel(config, host->ioaddr + var_info->core_dll_config);
>         }
>
> +       /*
> +        * HS400 requires a dedicated DDR/SDC4 DLL calibration step, perf=
ormed
> +        * once per calibration cycle once the clock is running above 100=
MHz.
> +        */
> +       if (enable && clock > MHZ(100) &&
> +           mmc->selected_mode =3D=3D MMC_HS_400 && priv->tuning_done &&
> +           !priv->calibration_done) {
> +               int ret =3D sdhci_msm_hs400_dll_calibration(host);
> +
> +               if (!ret) {
> +                       priv->calibration_done =3D true;
> +                       /* Safe to switch the data-path mux into HS400 ti=
ming now. */
> +                       sdhci_msm_hs400_select_in(host);
> +               } else {
> +                       printf("%s: Failed to calibrate DLL for HS400 mod=
e (%d)\n",
> +                              host->name, ret);
> +                       return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>
>  struct sdhci_ops msm_sdhci_ops =3D {
>         .config_dll =3D &msm_sdhci_config_dll,
> -       .set_control_reg =3D &sdhci_set_control_reg,
> +       .set_control_reg =3D &sdhci_msm_set_control_reg,
> +       .platform_execute_tuning =3D &sdhci_msm_execute_tuning,
>  };
>
>  static int msm_sdc_probe(struct udevice *dev)
> @@ -186,6 +892,7 @@ static int msm_sdc_probe(struct udevice *dev)
>         struct sdhci_host *host =3D &prv->host;
>         u32 core_version, core_minor, core_major;
>         struct reset_ctl bcr_rst;
> +       struct blk_desc *bdesc;
>         u32 caps;
>         int ret;
>
> @@ -235,6 +942,24 @@ static int msm_sdc_probe(struct udevice *dev)
>
>         log_debug("SDCC version %d.%d\n", core_major, core_minor);
>
> +       /* Feature support depends on the SDCC core version. */
> +       if (core_major =3D=3D 1 && core_minor >=3D 0x42)
> +               prv->use_14lpp_dll_reset =3D true;
> +
> +       if (core_major =3D=3D 1 && core_minor >=3D 0x71)
> +               prv->uses_tassadar_dll =3D true;
> +
> +       if (core_major =3D=3D 1 && core_minor < 0x34)
> +               prv->use_cdclp533 =3D true;
> +
> +       if (core_major =3D=3D 1 && core_minor >=3D 0x49)
> +               prv->updated_ddr_cfg =3D true;
> +
> +       dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
> +
> +       if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
> +               prv->ddr_config =3D DDR_CONFIG_POR_VAL;
> +
>         /*
>          * Support for some capabilities is not advertised by newer
>          * controller versions and must be explicitly enabled.
> @@ -249,6 +974,12 @@ static int msm_sdc_probe(struct udevice *dev)
>         if (ret)
>                 return ret;
>
> +       if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
> +               bdesc =3D mmc_get_blk_desc(&plat->mmc);
> +               if (bdesc)
> +                       bdesc->removable =3D 0;
> +       }
> +
>         host->mmc =3D &plat->mmc;
>         host->mmc->dev =3D dev;
>         host->ops =3D &msm_sdhci_ops;
> @@ -318,16 +1049,35 @@ static const struct msm_sdhc_variant_info msm_sdhc=
_mci_var =3D {
>         .mci_removed =3D false,
>
>         .core_dll_config =3D 0x100,
> +       .core_dll_status =3D 0x108,
> +       .core_dll_config_2 =3D 0x1b4,
>         .core_vendor_spec =3D 0x10c,
>         .core_vendor_spec_capabilities0 =3D 0x11c,
> +
> +       .core_ddr_200_cfg =3D 0x184,
> +       .core_vendor_spec3 =3D 0x1b0,
> +       .core_ddr_config_old =3D 0x1b8,
> +       .core_ddr_config =3D 0x1bc,
>  };
>
>  static const struct msm_sdhc_variant_info msm_sdhc_v5_var =3D {
>         .mci_removed =3D true,
>
>         .core_dll_config =3D 0x200,
> +       .core_dll_status =3D 0x208,
> +       .core_dll_config_2 =3D 0x254,
> +       .core_dll_config_3 =3D 0x258,
> +       .core_dll_usr_ctl =3D 0x388,
>         .core_vendor_spec =3D 0x20c,
>         .core_vendor_spec_capabilities0 =3D 0x21c,
> +
> +       .core_ddr_200_cfg =3D 0x224,
> +       .core_vendor_spec3 =3D 0x250,
> +       .core_ddr_config =3D 0x25c,
> +       /*
> +        * core_ddr_config_old not present on V5 - updated_ddr_cfg is
> +        * effectively always true here since V5 implies core_minor >=3D =
0x49
> +        */
>  };
>
>  static const struct udevice_id msm_mmc_ids[] =3D {
> --
> 2.34.1
>

Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A760A2624
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xJM+czvG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJy0ArVI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ipfCqu1P
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81B6F60855;
	Tue,  3 Nov 2026 15:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cS21knxLk5zN; Tue,  3 Nov 2026 15:42:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 751636085B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720566;
	b=ioBBMOpTMNBk32xvEBcspga5xvVEub1LqnPEiorqreYU4QWq5DeMO8f15qpsyegqHIDn
	 J67iq9lDoIKAO+CA7E2A/D9tUfjc5W2ui0BMDwU2oP5MxBHlCq/Sl1YVJGjruKkGaXOKH
	 gBLREcuZKKSeAn6L/9+jR8ErprgnWb1ISdsSqML2dMCgAkMAJd8SjmwhmY/nkhMAhs5+f
	 2FnhhTHajaGgXwYBmGh5rUwoQ/8U36SYbYzskMyPihVfZdWycmsnJxDDb55SkF52h9gCB
	 TU1GK8/qaUPQDy68PYzmtGM0hI0vPjs38nQ+LlStx68Ae8APgAEWrlH6k2IpjPzpFCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=;
	b=tD+G62jkbRWQJR8+wTTiMcG+rXCvWedRx4buiHtX254OwLaDH6DfuwsXqQdvTFNXFnOK
	 dT1HIQ2/Q6HEBNxQHBCny5bqw5vRTX7e96n+tgZF9l2LrE8ABVNT5Ii6jVjGIr0MYA7KZ
	 myuFlvPuq1YaONZmnJksQ82JzAHJ1IrAskYYdsjlRgTx9K0NyWzTb+Ev7xmKFeD+MXLx1
	 beJrHM9j9S8ZcBkCEmdBsM0n9f9hVMqOCsOvGiGpp3xwwWtWX/ccg+7Wf42klzyKCPh2A
	 MFiNLKwIa2r24Rz0JVH2Q0Fbqv0tpB49pDLcOs6l5cisma3O9OAu3K4sTzseKlSWILw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720566;
	bh=ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xJM+czvGmQv2WqK97oMyaSMzBN14mrckJopSPdVRWzRBwGFOOLGhiTwYVd6U0FzaE
	 yKzHvtjQXcACW/tyDOrt0HbgzyzrT/puf7H98iad82mhg8fvS66J2/djxdiom6Z6o6
	 oiDl5KHQ5qkpXDdZZXzm9umKA//5rKkYBW1rF+Y/7/0cQ8z4NfmgXOb/3sHfDvKvs5
	 TP0OADPyOXNj7xSTa/lTq/C6u78UNghWBAnUF0/zG6yg+pSY/rRqUF/diwnPNS5hQ2
	 XZtqezn0jS0REjBWMLbmmcC+S+XO7nRc9wteMdeYFgbLF3vpV7QAMuiRy9eBSF/1UZ
	 EBHX5CT7hGrqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 751636085B;
	Tue,  3 Nov 2026 15:42:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD9A7235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C317C40695
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0PsnjRHB9bY for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCC4540669
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720564;
 b=pjInoyuCHZy2xlcmYLjGwoOJ0EpPmipFCTtJ4jYeB31aumjAtZl6VR8Rjos4anNk2d8M
 ZpqfB9ZWgvHCgTGcoL4n2YzAemOcoA0FTQlge53S/ykuI4cm3Wbu9f15+Ny8ojyYBLRRZ
 4RgyOndFx5d0PwRwN3lVgFq96lZOaUOXBHKv0WnGy6ueGAbQAcRZ0Ke02Fc/Ci5re6The
 1dZPZd7ATuVtwvlub/yIn8opBhWWnO8Jsh+fIx2P98IuqJY9+N1WjOSN2j9Lkv6uJbyXK
 QPmsSFSbyZkSJE8xV1SJpQo2vggB9nJgQcO4yWTlDx3sVCcExzhGGSkGAZamMEDf6Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720564;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=;
 b=Nye1a44GF4lPAjqp1CmDoTrYVhuz63fKVJgW5xMphWbYU4OyPD4fYmRcStc+i+QVS1AC
 nOZV2oVuMM/N38dfxOK1Nt+Vauj4oJshK/Fbsuoh91j0oL98XEwHDlZRRF3FE5oDCgeOa
 pS0UH3wQv8LeS5jIQmV/8CKsKzl50Q6v81BmasdYIYfEZWALbBd8qVI1HTy1fu+H0yHg9
 930QNMX5s4JCfG125YvcuqAAYTBd02twsI6phF7ctVoMtDQZWQCL4ch38uUpkdE/LrNLp
 TIKiL5pLVjgkB2i26DpiXsK4T2QNMbG8/kC06ZgCZ6PpMaKasLSHrDoC10O12MJmH8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hJy0ArVI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ipfCqu1P; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hJy0ArVI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ipfCqu1P
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCC4540669
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:42:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3E9n7n4049225
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=; b=hJy0ArVIP4lYxU6a
 ck2e6Mu4NS3ajSmUuOaDJi4jJaa4dsbVRZ60H5zIDj2ZOmQbG2zOSzj0gISSg4Mn
 pIe3kAkWu+6KHk10WK3dTZmLhPs/DIPjGiQdKu1chAS/A9BG0cBWEbQg7k1/0KsP
 TSI+xoPfB+GLccz58JhxYYns4+NaBtVy5QJgJTMXg0m6zghLVNQpSfdpeKyabhuN
 wUfyL5OuFkD3EcWvp0QAu8xiGMU98EW0VE3mwoiS7TTczfxgC/qL7TYDpen0ibJ+
 C+ZCvHiwTOIz4eQoyI+vlLD9T0hseQsPE7fODcsH68f5VDPl0DnOQlu0jkmGVZbd
 K8vp9A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy3me7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 15:42:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso7766735eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793720562; x=1794325362;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=;
 b=ipfCqu1PaBa5RIg51ZT9RKcu8aEhxU8AeHYBDRdTuy4qh1G5uyBpX/9NVk4iOiNHP6
 d7Te/lK9UGG7k+sIBcZhPc8jrxlHEDnaAYTx1tbnCvXBmX8jGC2pV6OYFy98hkGt2kGC
 TBrBJ2yhg+8Di3SQwKWV81vsgMlXEyzsdckSPSK0cDbAL7alL4VI3SwyrZ259bhzYwjQ
 kGXh0IpHgZOdXTgSlkCy2rQc80Fpv/rn2pARTrhF3tFm2HhdPA+h97oT1kgn0c79ajw2
 NGpULmkkoHLfRoRb9WAimlm5j+2y5BIi/kcPigW6pS3qmWIk5Cz+3KAmiMmK/k4K7OGN
 /KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720562; x=1794325362;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ADz5+NUVNHyzbDElhBdKTmGme1Sb8eTb7T6dSIe+mJ4=;
 b=BzhFOjprHQUbQYIH2X2NRrD4d3bKEU+mpkDvJ+oZ/7/XSPSFl/i7oKNHGWiQv+6MVn
 N6JPNc36COCRlWX4kkagF8zEyaPah6A9thwAEy+dbbDdocdQs4GZ0NKJE/Y6k7tK2mzL
 R5HHbvTNIERdFyOz91KeYBqkUWG4ul/aiY+uAmWkYxMZElYB0CzNqadqd+w9/OrkkBgc
 4A7u2EBAqyDmk1vHBHNDCDE6n4nY+xEN5sT9eRw5yt6NSBmGKon2stj+ZiW2c55RonJC
 4GiYHWVbEBjPhaRSMZGYUsJHELhA9Z1Man+3f7EWTrcaw0jWU9WWbFzpJQ1L3hrkN1TJ
 iRgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2QNCFfvi54FN7CdEuClzgHO7qFyfdw0mwGEjpjqaiuFFFyS7p/bfxpaw62WzwB9CaaBle6C8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/7qAo0QfBW0TUu8TdwXjbhd3gFvFzd/PuIeFdHqOtgmxU1/Z4C
 3yWaaiCJ93oZUMJiQi7K6hCGQ7MxDvcBZtVJEkRAsdHmT3wpJKKsTAM6DJycjGP1DYNM3JfGOgX
 vTGAdkrXQsGRQQuwMuqTeJ7Efs2pStlEj2TVr34zzaksUVxnPyBQFET6z2qtLhf5kIvtVXmg=
X-Gm-Gg: AYBFou09mqjaAZFHk/ARIa4EmvmuiihGrIS/Yz/6FH0AigV/d8/W3/n3y6B0sTvd8Fi
 gsW+cCec2GigXpLxUuS2Oq7OtTBVx35t9es0f076oAzVCxcXSIsfNoxC5EZx7lwHUz6ZgS6uSRI
 mZI98Ri7WYdfTKh56+9X5zGAzlYWNzA2mIypkJooncuivpHx+C8RpqBAkT8OQ4Q/F+pkDztbuLG
 qg+4EpnAqpr5GgT5MXtGh1bUHL7Z3KxMUW/pVhxnhAc1BHgV5Y7a5cxvbEvV0XZmqIx2161PtSa
 XrddzYZJMZruAXJUBWteV7jsGWlZR7o55K5d9HOvdaKPqvOpVpzoAc+9zHA+1o7U1Vgj4go7h4V
 TYWyVvVhIgm8lhTbh9TXpx6tnsWzpxp9IJsWFz5+wn+UMCXF+vi3EvSZsXPPC4N3guvqHzBGbmO
 XiMV8vihw=
X-Received: by 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id
 5a478bee46e88-36a424988abmr23287033eec.41.1793720561485; 
 Tue, 03 Nov 2026 07:42:41 -0800 (PST)
X-Received: by 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id
 5a478bee46e88-36a424988abmr23286993eec.41.1793720560900; 
 Tue, 03 Nov 2026 07:42:40 -0800 (PST)
Received: from [192.168.0.5] ([49.206.97.141])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42662f23sm54593226eec.2.2026.11.03.07.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:42:40 -0800 (PST)
Message-ID: <212739e2-80fc-4fe7-8830-d648c77d93c2@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 21:12:36 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
 <87ldb07bdb.fsf@kernel.org>
 <b03aa068-c69b-427d-a50d-b5b3ad391cf4@oss.qualcomm.com>
 <xhkdb5wyl2arz.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <xhkdb5wyl2arz.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PPMMpLbWT-2tsZyXX_-io94v4poGfgBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX4LPHTVWR9fb/
 dKNBwwHHuuP7pVE+E6O4aOWP4qMzoqmmnZP7kaJrPlulogaQOeqhbdqkPzah7I0TzKasnhyC0QQ
 pCDm4Zu7MfVOMuPEbpyrxwp3u3qowA9PUzrBLtz1OKJEEZ6c/7TzuRvklKPPxXhQq59SieAgZKX
 1fTakKjdVfZ/e8yIaKet30WcFw3i9k3cPJtBAHMgDmhwM8JNgb77g8raVXtPfIY2uAr3wxgdGfg
 LCm3DVAqYbRUAwcM4oFUEHTk2tGN7LPug00Z3RFjzSdjQgcWSFKMJ2csS0c5h4MmLpZSMljzQT2
 p7qzCzbpzBa7ixlDS3QWjmXHXn1vjqDAB3OUfY5sW8si8CqivXlr8waGAREmaOtOA1Rivpyi6CQ
 hlAP70ewOcOpueG2rwJTjwB9BQn+qs4vvCW+c/Oa5EJnLb7qJ1BppA7DiHRGc1F3x90jnjpMIaT
 IVHpg1xVz4HgKciPSVA==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6aea00f2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=nNSuycJrq3YNisLFxgOcLg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=rsQ5oyvOBPmVHO_VwjEA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PPMMpLbWT-2tsZyXX_-io94v4poGfgBT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX56wGFgjJ5zZU
 3f/57RJdt9U1ePi010y1ZphiiVyyRoQIDLM/rYXYdtmwCvMWYtsHv6ozgoC4U3ZDss+VrD/Ceko
 624HHNu1Oca+fkyIHI4yNRWOwhwpNCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030062
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On 10/29/2026 1:34 PM, Mattijs Korpershoek wrote:
> Hi Balaji,
>
> On Tue, Oct 13, 2026 at 22:19, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>
>> Hi Mattijs,
>>
>> Sorry for late reply.
>>
>> On 7/24/2026 7:12 PM, Mattijs Korpershoek wrote:
>>> Hi Balaji,
>>>
>>> Thank you for the patch.
>>>
>>> On Fri, Jul 24, 2026 at 14:58, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>
>>>> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>>>>
>>>> The delay is unnecessary. Upstream Linux does not add this delay after
>>>> the core soft reset and the USB works fine without it.
>>>>
>>>> Tested in QCS6490 RB3Gen2 Qualcomm board.
>>>>
>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>> ---
>>>> - This is part of ongoing initiative to reduce boot time across all
>>>>     Qualcomm boards. So we can remove this unnecessary delay.
>>>> - Actually, this delay was removed in the Kodiak v4 series:
>>>>     https://lore.kernel.org/u-boot/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
>>>>     but v3 series got picked up: https://lore.kernel.org/u-boot/177745255938.126665.16625119085748603933.b4-ty@b4/
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index be198041f08..ae22e1c792d 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -106,8 +106,6 @@ done:
>>>>    	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
>>>>    		mdelay(50);
>>>>    
>>>> -	mdelay(100);
>>>> -
>>> The dwc3 driver is not only used by qualcomm, but many other SoCs.
>>>
>>> That delay indeed does not exist as is in the Linux driver since the
>>> following commit f59dcab17629 ("usb: dwc3: core: improve reset sequence")
>> Yes, this delay doesn't exist in Linux driver and the delay was added by
>> me in 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>>
>> But found later that this delay is actually not required and hence would
>> like to revert it. Have tested the revert on QCM6490 and USB inits fine.
>>
>>> However, that commit is more conservative by adding retries and such.
>>>
>>> I'd prefer to stick with Linux's approach here.
>>>
>>> Also note, there is an ongoing effort of updating the dwc3 driver by
>>> Linaro here:
>>>
>>> https://lore.kernel.org/all/20260716134305.614278-1-anders.roxell@linaro.org/
>>>
>>> Could you maybe give that a try? It should have the
>>> "usb: dwc3: core: improve reset sequence" patch in there.
>> I agree the Linaro series is the right long-term fix, since it carries
>> the retry-based approach from Linux rather than a flat delay.
>> That series touches a fair amount of the reset sequence though, and it
>> may take a while to land upstream.
>>
>> Given that, would you be open to taking this revert now as an interim
>> fix, since it's tested not to regress the platform it was added for?
> No, I'd like that we (as a community) spend time to do the right
> long-term fix.
>
> Please consider testing Ander's series (latest is v10 here:
> https://lore.kernel.org/all/20261028141554.3073545-1-anders.roxell@linaro.org/)
>
> Testing on hardware is very useful and will help to include the long
> term fix from Anders
>
> Thanks
> Mattijs

Sure, will test this series. Thanks.

Regards,

Balaji

>
>> Regards,
>>
>> Balaji
>>
>>>>    	return 0;
>>>>    }
>>>>    
>>>>
>>>> ---
>>>> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
>>>> change-id: 20260724-kodiak_delay-a5f1e8b675cd
>>>>
>>>> Best regards,
>>>> -- 
>>>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

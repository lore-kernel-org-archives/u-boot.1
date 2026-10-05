Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA16CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36E884068E;
	Mon,  5 Oct 2026 07:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YfPeoWKd2kXM; Mon,  5 Oct 2026 07:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D21540674
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183670;
	b=qaMeA7f/xCviH1x+ShoyWDEe+4O2TI8CZAlBynXIz3Q32izU/lKD6oFk4a33BWFP0k9U
	 7hfvP24hWSC6lEckLgWuyJW90WLstvizES4oqedultSuSnQL2GdN05u4PvyXjkMpmQRT+
	 RIo0LncnVbWvV0XhxBDEOAhMYejGWow/lfNQ3ZEiYQn/CePSfrpFe81ZgQS49X5VApqUG
	 4E43VS3OPfvDXe3CEU8etNtVtFgn3IMhgui34E91/zNtUhLumielGqsrGgCu10OShDZI6
	 RAnXX9mZ7XhYjqoi4NbIh74sQemyp+LIJ3hDVIoj0W/G9C5LznSuT6JzDmLdIGoN2NA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	b=LXjQEo4wBvSCgpj6hsWhGnd01eG+RC0cQKNwiolJzJUBCDOjozwDVKMi3AYv+y+7YM3K
	 dVJyacYq+9HeFFEyX6yccCdOr8bTvADW/kii65DzqUhRg/F5Wd2SED9dh6X68NQx1MLtM
	 w+/IaOXDETqEydQRZe8mNDBbjHcly1oA69PyVLJZyejYJ6b58K+N5kEWHdpVjJ0Qductp
	 fbVYCyLmy8KlokEhIKmYtsmmyJHRqpOwnDp4lZolUmkLAk2BmYWDGTRt37XIZnuGDu5Wy
	 4R3YMcW4fy177T0LDXa70sbyMMR3UKQ+1s1LfqnLfhbBSewRmdbO4YFrk+0yM4k7nRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183670;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIadeOW/dSfj7IDwnGnzuXKS0dd/BVroKOqzSsOFhl5GgEs9727Cl+wRN6/4Er46R
	 l81o9DyV4Jm1kRDySepMlFxjUoaLlo2UAdGQCv8l6S2byL09c0pmapTQ8meVf7cuu8
	 YI1X38gnFR0ITlBluuAOE8MkJgIsV7GTkH2ohNG/2cAO9Gt0qQtCldpbm/l+JWgzjk
	 4G1pLlseUqbXyUElKI2IOqxrJpq/eaifkj+1rOUbkkljU3+mXpwrjnJ/pNr/uWvbcy
	 4bjqbNNm7aY89+cljExW9V1XjoRPGm9zK6GKYwJXU5eQvvf7zzb8HmN7weXc9w96ii
	 zz3B1azu+VkmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D21540674;
	Mon,  5 Oct 2026 07:01:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E4A1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97BB860606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1n0Fxlg_bEl for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 00181605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183619;
 b=dIcD4rMv1WqaN5OjSsvVHiym6QJthOTlD/KkcT59R5mdpGcJMMe2tJeY88EvN7PXYnqN
 FvU9T7rZ6MbDrrtKcDQtmEWA9My0H94h0WRuIxYN84rPZVorXXzLumd6zl0ij6mnGWn13
 +jl9NHyTIuOYDYweDbqx9ss2u6rSZvW1scQmkPktBo6MuHEpazPOIkYm29K4DvIA+rnIR
 F8fgLP8wOAUAwK6BXnJ4MLzCG528e2tSxZdb78p6Hv6BlC8hMz/OCADUMTPcKJGH8bNHy
 QLr53x4u3Fy2tlWYwtN+2UqnfAYs4dQbcwRaVec57WC0jHF1aJjuW1Vy7gaJU+ven6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183619;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=ktwXdic5XDisTX+iR0TnNy73k3Hh8b1l1eMzOsbgze/ha7c2BHivIUQBxi8Bo/X6HE84
 aznmZLCpk/k87M6nNQ5IPrAwTFi9zGe9L08gN14MGv4773hjVN9G1lrYV0j3nSoN9ig9t
 WQXkbOLaQ7Ixm4qYCgqOoIGflUxCVDohQbtje5x4eKu7qsgKhF0c4P7CeHaNR9QHqYO8q
 xMbFKnIR1nnuXmdyl2MiCfBobMPnrc1g55USm9g35izlA/5HhrsX1hBMvjY8yjHDTKKih
 3d0yVWvKYTW39rbhHZmZanr+N1IDRUBF9N1bg1lILNOUjNlU2YWeviEm4I7ENy2ISWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Wk2RL5du; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aM5EOxsd; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wk2RL5du; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aM5EOxsd
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00181605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695107E33242503
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=; b=Wk2RL5duHGW1oczJ
 Nlz13PiQilnXLJ0J1VHeU1OWTKWUK54M7+Nlk6UvmnxMKh5LcFVulzjeQtR+4irC
 DKgQFL2n2aOycJCWp2ZLJOqHgdpBVfRYBdov+wAy6+cf5drkNz13Plog4ARoFs3A
 dFRmjhduEctluMM7+BGJl2crnpdtcQYwcws7ewhLbuv/m/uJBuedtXWDIrLtuzfH
 JWSFxpL900KhKrhbJUlU4AbR/4CJhMgSRBJw0+AQOr3xYp11uXWa5lcytiZ0WbpC
 esziN+t0nGQ0dg9Rua17wl4JiRU4fZMlquLAVX6Sfj1Djh9BvZqvpcyZQb79BTqt
 PvU6xg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevnuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:00:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso824600eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183617; x=1791788417;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=aM5EOxsdeWcFhN3RVXYjK7Zr4kBFha8pU3X1WolU33eoSTZZEp0J/Do0+NQ1ZTRM62
 Op0s4idDzyUsHWmLJgcAaq9aapJlxW/wZDdKLQPhfJaZXo5XvjvPBp2gVHIv8ELY7SQ2
 hzTizkdp5+e5jhp0eNDk7kT9UflRy+ylTsegWjyyxmtmWxs6u8Z5Krbz4WwTLyJUHhW7
 VXLJ9y8UN8muHimfbV3hw6AOHEVNyf5c7EU+7reEKaKk+QgcMNt1g4TXcovw124OKyPx
 QTpV+IXE6+xSZnxn2J5xV3Rr7xC35l2zZ+kcezJwjansLKZfsQC4bMwFf51oqNzmcvZP
 9V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183617; x=1791788417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=Q6MOqBuGvxvJbQjIDWMHVsTli2V7bozz4YRtqiFvUW8pb+DJGrLXYscy0iyEOSDlXc
 mgBE46tc/FwtyzlzA05eEjq6QLMsf50jb22WZG1lQtyRJ0n3n/gHCm4eMiW6cVbgVHKX
 oKCOK/yN/pNHdvZ4HmyrSSKxJanN8R475gaiOHcIeqGfNz968eS3R2bSanF0D2zGIk3r
 NpVobC4jVmba23aU9nBSmXgIxGl7scE5Iys8/BktAhgfEtonOZ4hrBOqe8EPxEDky1ld
 yintQsYITgrbp5FxycZ5QG0q0p/U0E8wivwU3Ozn5jKTUM9L/ObT3f1cJ/LdXxW8PSnK
 YdVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBys5rsjHX3Fh2woooqDJD3zNJxHJQtQslOrg7SBdi4T92OvE5IQCUCz+FiQ4mpla+qIGDw9rFA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBpbQOwvaeeR57XJAfTSeJBIGEBEUUcghPoHHHPIIhgaISy526
 IgA99k7HrYY/8NVaMfFWhuNg+82pojYBJCy5ZiUJDYEPiJ7VA/wdhbaU3UKrkUh2G5YqTfhWEVP
 hWSdP4pWhWIUJ75bk5QU/2zrxD93DQkHxVuR17NcQcNtYSkStRQOnQW6E/DjgKZ0IRxmn6P3MbT
 BOFIo=
X-Gm-Gg: AYBFou0ssPMCwQNWbWEHDOkMt22Tch+N3BN5vn7Mlh2QvC+/Evq4IchQdzwJrCZ1lBh
 CwQl9dVy0DlsK1ij7wo3HBG9nCWzx/Avfs41DgW+EoLzilLSuyfmGMQ+05bnkiOUKii5nXvnbod
 ZJIgIQlw1Jm0VdWJF0PMxMgCAJrJymh6/wqcH4f75SPPlLFpWCb1gwOcA3wqkAETKvwrJUqgahO
 8mKHvmRu0T6lX9jZaBakKROLglLqWQ0BQqUrs45kZhwKnZUiYGi0rsmm3uWx4eEaGy4rEOUCW/U
 0sXhY94EaqzUTjhZ9ed/ekWU2Lwi92M5gbND5G+e3v4I6UWzyj15oKVY6Hocl6I+QTS2+1yKI49
 UJbuHnGJGgz0T10FVxqhBG+vJWYsQlMMkSbHXsV84C6z4uNjxUOON9ZL1CvmFFC18VgGZcNoYFU
 k7JmCMWW4Dg3DMRRxu8lh6pYPileGS
X-Received: by 2002:a05:701b:2905:b0:14f:a812:71e6 with SMTP id
 a92af1059eb24-14fa8127380mr10006001c88.5.1791183615292; 
 Mon, 05 Oct 2026 00:00:15 -0700 (PDT)
X-Received: by 2002:a05:701b:2905:b0:14f:a812:71e6 with SMTP id
 a92af1059eb24-14fa8127380mr10005811c88.5.1791183612094; 
 Mon, 05 Oct 2026 00:00:12 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm27963498c88.10.2026.10.05.00.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:00:11 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:29:55 +0530
Subject: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and debug
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ipq5210-v3-2-e0ec14fb5796@oss.qualcomm.com>
References: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
In-Reply-To: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: bF6MOwpw6RljmHphtbxwM54xVqpn54Km
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX6TLfBlHDAF7j
 FLLsgWjqWhnAc8ZPXfGP7tFFBS6jCN96ubc6HZeHANzbqpcCIBlxu3F2wGbXbQmt237x8xO9vex
 Zv5RoTjlnwZZk8OZN9C/F7gvEPXNmCg=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34b01 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=unZPNS3TcTlehdJ43tMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX4Zdk/WAIQFD4
 m63b4IYJok8fI6b3Gc2ITJnGYgXFplMEi18+H2uQ9O69z+Fm2QeNmRSjcliXru009EPs8RYoUM0
 L7XnmbGPZBR5MaV6FXH5NJYrehTskQ5NMXcw7azQOTieowQYxaSmOj6s3g8mPi/jIARFuaoZs7J
 VUngHm+T4rbHLrZpR+26Yk3WyKNa6a26b5GcdOJdXcrQWSMUx3pJOGOTQAYOPzHbnTuiUMWw2h4
 pTNumprJ3ahUIzFpc94BaURwKK3S1MJaw9ACNzH18g2P6+Vwd6y5lupJ2Z8Na657OCpyaEDM0y6
 H1NLXQ6kKRc0DA8uzSCLoQguF3be0qELEkvzlzgvWJfv9Sw/yy6G0vaQ8Krynt8j3fOcFN/PRkt
 r+vjK1cYofBC74eSOkgsuabvKmE1zKDSuh3AnkC/6qB11khkbbXeEeac//Wtq0+Co2dGeUgI3jB
 jDx8RT6Y+tIdpCrOueg==
X-Proofpoint-GUID: bF6MOwpw6RljmHphtbxwM54xVqpn54Km
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add a defconfig for running on sm8550 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..40f7c857007
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,16 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_QCOM_GENERATE_MBN=y

-- 
2.34.1


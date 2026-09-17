Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035EC982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 664F96082A;
	Thu, 17 Sep 2026 07:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruONR9Iu9x6g; Thu, 17 Sep 2026 07:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE5BB60659
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628409;
	b=be19VhHcDlHTCCfJZW9OKen59Fx9Bdd++ZEZAT9uNbx2x80UWb6cOKZlp4oU5H6RV/CN
	 1oJ329cM2yPvZzNcq/5NVhAZcFpdkIU+n7SOdOImPju2ChhIhf/i36FmT0Q6mQltISA51
	 hErOAhAtorNRB2ArP27l/hMpcCNYQ6vqnf7E8GK0xkRuzcFNfDAzXsdinBKEguz5ZSvDB
	 mEdD8zIbfRVWn9nMOfwCnXq/B/QyQtTg94/g39V+ATKzwtkLVYYP5u89koIYlM0hijWLE
	 jTNEMdSMB6IlHJ92gwtlsTt+m8mHcGvAD6QyKlgglbt9zy0evidkW8OIMnWITAXw6Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=;
	b=pWjQs7jH4lpX8dTve+EYTBhDDZizIW2qyrKQeZgtQeGSi6vnCJu8QFHjHG0TMIqblzRk
	 jCiqUXQn5LrC3GqoD0HAPq8NySqRZmrotU87Yew20Xq5UJVUeKqNmdVx2Nw1tijmTQvt7
	 E03vDis53SNhxml8jZH0wZLEr712IPi6GpoIJ/kyLT7b3Ue8kTk2gHtDqzwBXvk60opvx
	 mtdi6/jH9BtcEFbQt5xLqizbVWg79S9pRIs1Yo5d4EHLHyjOFq9xCvxhVsCUkJ7+YFg3i
	 0aRZmAzLO969mieycUCm3KoUKl94ZLtVkufE14escT1ou45RoV4nXBYPqvXtcaDBDPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789628409;
	bh=FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G84pne2ASOa8/3N0VXOxLARhUBVt6DgeJEtfzHUOCDJJkfSGsqnEfzI5lVL0B/E3n
	 4Cpf4I0SdMYmYJZn4Fc/UcaDplDNQ2ONd4qBlN4Rrd1wNuhMi8f0BK6CFxgqllDYRA
	 AbZFoMaAIltIYlohiO2q0AUKMOfOa8WwMo+NC6gUdbj0vAVUXJoDdWHl5/aAAVkyqr
	 YeOGFBLNv4QadQEnKlw1Wj9CI/F0p6GbcGlJrXdxEuAsBoxwI8hAEf3O30xRkYu7kT
	 ueRkvjLIuXKmRuXtxFoFvM8rSZeB6X7dutO7kJAvDkRCOH11rXyHsR5BUpaM1tfgO2
	 2q1hC3e788ZVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE5BB60659;
	Thu, 17 Sep 2026 07:00:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0690EA29
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 046E8400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOJne2EchnDh for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DCA4D4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628407;
 b=Sfjqd3SBHWnKJAyLYvZw4ejyh1XPevfmWaqKNnCSJxjwckKsN7FejVYspTEWIFds3aC+
 Ia8uzpS8PgJwhhrz2p5WKt7/E7adoIk89c3hczvzdCgMqumHpQlj/NDmrhuM82/TDjcZl
 AdjJxDLgC0BIqCev28LyQTV1sNNt7P4jQdpnPLcI5G8PvFvKIbE3Tsnl9El12OTijjEFW
 BoYr1y/i0ofcSmQ3iq3N4uB7zBeJjNucCao8QKNYaX7DHJcBCqCeIHkYsCi4U0FYunrcm
 GndwNyC6qd68Yz1AF6tJ1iokSuILiMTOI/niZNECk52GB8cHMQE3DmvRapupcKAkj7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628407;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=;
 b=B9mtz+xnYlEtFKLqs6Bib2/H54VRAihHv6KJqSyEmTE62QDzS/f96XVmLaY3pmi4h1eN
 Nix4XbCNTw7Qp1vNZzFo1Kw+/lxCNzhAM7m4JkVmzeX6Lyp00wLlcMs2gYlD8kSgCoT94
 I6mRM7xnGIPIU5/lDB3bkfZcxE3mPhYBzQ6K1R5KdhqYTvO453UzeYI6ixMBb6Rc8OARK
 D9Qi6Yq5tWCyjdavNG/gXRY6aEPoiZ542LjSugz/iNoNxEhEOiqZmAsCHm7O2hgTDdNO0
 kNApIKfU4gDXDICjiZyXvrjTcfJ2+kdqs06HAcK4vXqp/Tq7khbfKJArHAGWmHbiKZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gAp+RrPx; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVpmlR0O; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gAp+RrPx; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVpmlR0O
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCA4D4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H610rl1375883
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=; b=gAp+RrPxESuU1V9o
 PyqiaX4nvi8S43pgvzZyDxVInbfnjxB8qPz2oXiEhdZlibR6GBIM4lv3Jm6gMV5c
 XdHjqiRigLNZw8yHKg7mXRHq6Qn3Cjw7VzpiWk9UuD7OByv5I62MGgoFYGeD1ynp
 niD18WAptKxMDnUviGNOfYrR5WBzSTMlS1QtWmwBSMzYK1/FCd8+4uMynAeGX+lJ
 kcFhx7W35QYxF6uV2M2mjHi+07dr+VrEiwxiOHLZTRFDcNhUna/7nPkRjzLSkysG
 G8vBoQqntwAzZ6cetnrdBynOFgfkkAGNehGZmILcA32hAZXv/fVs+dQAu+7CKe20
 uGssug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6atv2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so748842a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628404; x=1790233204;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=;
 b=FVpmlR0OF7SuX54C8RG045MXJzIidOq8ERFn18ICajrtETqr7bYlTcMo0fHV6B61uE
 L4DnCWomTAd0wC1m5RP8qWHZw07yzGX9IQzc28bK0dooyslXnS2fQS0aurx7bKT1dN1s
 QoI0TIeT0+8RPJy6S9BQkXdxken9wOtkMar0SxXLXTK+uWVCoo5VX3fYbqFxcWrhnuNO
 8yyouiZSvGORAYN7hb+Zlaki8row8djq2mVCNbZaTm8umgQrzn7K5OYtwSaUbezd69lb
 bGm2blCdIarhyQRTQW9vjQSr5VDEcTefeh25DYXM69DnSdua6QWcFCf9w5RzLdX6DeWS
 SDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628404; x=1790233204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FNh37EQ/oEYF7fUMXjWjqIfRDqhGh9YDmLSQFpXRArg=;
 b=fP60ftaExsfrxKS8l3UF8BmG4fpYXiAeO4lD2AvqcPlN8z5H57nbySfCRwm/lI6ik5
 jpLXFgRuODupEnz8pn/tgEXYfwcS/5zVle400iEzhfxibNyzn+4wMA4ve2Pg4Mp2IJsO
 NZkvU7bGvf2ZiayPzb1jOJGD2wt/AiH5qdpcYKnm8VTqWGKbspsUo1ggCY9gfXtgwhip
 lBycsS6ggK9849aH6NmRgnfzfC3z156HDm5BF8IE7yY1O+CW4qyUVVetQbvyElsoCqLr
 MeJWwpRzVtYlDfvYOjmO1ahXhVB8lUqsjpc73J2Ge3XdxlwFtM+jgu4gUrwtq7wEd9JP
 4hNw==
X-Gm-Message-State: AFuF++luYBRz4ef7xTaaEXBzgj7YIqVcGmbfefr3la3MjBxDL0b3Yqkx
 SXl2e3eQverjp9xBHQjll0oH1yUdhfP6Z4o6ehRD7gAeVTPRgCsqCWKN4ndMj/DlAjt2E+2Q6sT
 C+q3a2octp1zabPo3AuUA+j58W4+epdm2OH6XbA/heI+7ie+rmtnu38cOK7+R1bTvQEwlKXk=
X-Gm-Gg: AYBFou055KJnyJdN2GQkjAyZwqSaq6QalCXBudTRBqtVZaQRxPJxEYF7a3J8fFkRnKT
 oJZnnrfEDliipziZxM4jNlfkTPEqX4dRqMSZ75xB5KJbxhcdhNW0nznf99KX+rCMC7IdqaY/OUw
 3Jv/cIO79NbyJKyGGVogMq8qcdMnZQmWX0sXkicBnMD44yNqLsNWZ9qSeFCR9KNHBxarOB8UAZm
 PNfjaoInhacuvlxr1LcQbW3xw8BjrkDCCrg9Ob7P7HLLRTSkzvbtUv3myA2Ui8NLmghOe3b8MGn
 BCyScxVeMSQ4/p7ErjCsgX49oEeYoW3EV+W1bLR8KzOBdukwq2VylAa1DoZELSqwXFQrgKvVV2c
 tCW4csFPN5OPV4N1O6ym/NJYyqwJ18O9T3KvHp6HRqEFFzPF+8kTNdiXv0FTmGleAnlwbwTsPEG
 i18VqICMYWdmc9I0qQHKgD9bplxMv9a446zNChj5c=
X-Received: by 2002:a17:90b:5810:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e1e4923f6mr12932304a91.15.1789628404233; 
 Thu, 17 Sep 2026 00:00:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5810:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e1e4923f6mr12932226a91.15.1789628403765; 
 Thu, 17 Sep 2026 00:00:03 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm11974416eec.17.2026.09.16.23.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:00:03 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:29:47 +0530
Subject: [PATCH 3/4] blk: uclass: dispatch UCLASS_MTD lookups by block
 descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series1-spinor-mtd-gpt-v1-3-d065abbc7454@oss.qualcomm.com>
References: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
In-Reply-To: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628386; l=1133;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=FBDGvi5J6HoplbZMSK6ViPJbAq3T6s+Kt7BrjaCWdZM=;
 b=iRW8zVRBbnm/TrBA/HmKi5lb2agg1OPqWVFL+NqsUI8aIKoOlEkhVlRouIo+NHWn6tvXUF7hu
 /fm1hjQCTyQBzS1BIu96r+y0yCQRp5h2eARmDqSlaa7J7DU7R+Odm1d
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: D4Rqh6Nfs-HHY2FZOWIHgWJZ00cS6jYm
X-Proofpoint-ORIG-GUID: D4Rqh6Nfs-HHY2FZOWIHgWJZ00cS6jYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXxKnwc90zGjHY
 tObUgfGW/mi37iyzDDEOWZzK8unr4Xf7FDAdT7snCUDkScTI/luWJJcoH+xe+m6DskqyrioaRzN
 EyhW2HC5JD3o5ybtWA010Z8+lw8O1BZC+sw583bmBGl+5mtUpqzCoh7GoESf9sgJ+6R1qnbtwgv
 NFoyoz4hL6FrMCr1C4TxwzR56129/1qglAZj0cjHBnk1jFBKl/INneMN7w1IyyvtXiL/AuUGsS8
 DML2WghakWdKila9ILmYJn412g3ym62scJDPXTms0S+nYZOq5a1OCefF+zry78LvCjbGG+eV+WI
 kcuhuW1Tt/+qn+GgSytx82TTQrhyGSkch8SK+g0jmcX7NhxX9fvtiQlZhbVMEDk3CB6YQQMe/mh
 EzqRrps4YEZKkTux2o4NK1E7hny+8RVAfPLiV+XUjpO1dDLgbuQUByKairF94anuZ50/CYsWTjN
 IKy9ssQ+WTA5wWdJHIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX6YlTa8jeN6aC
 osHPRNvBYYHloa+CUxJRjfn5xt11tqYY3oQywzWJoxdCvG6dyX0UzHK6YG5OlxvYAR3uWJHCPBy
 lOS4Cuq00uXq9KTtwJZKf6qnJz9Nyh0=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aab8ff5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yLItsQnbMmdtGSEzpXIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170093
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

For uclass_id == UCLASS_MTD, resolve
blk_get_devnum_by_uclass_idname() via
blk_get_devnum_by_uclass_id(UCLASS_MTD, devnum), matching on the
block descriptor's own uclass_id rather than its parent device's
uclass. SPI-NOR backed mtdblock/ubiblock devices are parented by a
UCLASS_SPI_FLASH device, so the generic parent-uclass matching loop
never finds them; SPI-NAND and parallel NOR are unaffected since
their MTD block devices are parented directly by a UCLASS_MTD
device.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/block/blk-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 73c24fd9176..37f39817bc3 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -128,6 +128,9 @@ struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname, int
 		return NULL;
 	}
 
+	if (uclass_id == UCLASS_MTD)
+		return blk_get_devnum_by_uclass_id(UCLASS_MTD, devnum);
+
 	ret = uclass_get(UCLASS_BLK, &uc);
 	if (ret)
 		return NULL;

-- 
2.34.1


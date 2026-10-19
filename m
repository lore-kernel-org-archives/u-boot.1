Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C242CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E93B6067A;
	Mon, 19 Oct 2026 12:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtnrEzhhZwRm; Mon, 19 Oct 2026 12:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33C3F60634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411666;
	b=aepwTNrjNBhgDpgGERKhGjkLSRlPL7LINeoV0To3U/RVrlUa0bflxrHnWTzEyGsXT7Ce
	 1xn70T+vmxRMyoIznsKHpgtuh9t7RXj2bub7tkqK2Q4mSvxsZlEpKoqTcBpnYkwd7FCmS
	 OV28sqIXWHLl+CV/xegHZCd6D+fWIUeVcJsdDJTeJwpYIlenBKpbb7FCCZ8Qw7/26ePdw
	 kY5zRueWeuS+DZEUdj9XQgAieDsHBw2WRq3KBgV8qPP1Hbxgk8WNsIBnpDYIGzR34bI9X
	 9xnWuSUdN+s8fXDbezBFuU//OnkhW/rJ6qKqe+IB9Bw1G7JyLl51Mx3TprrZfT985Dw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
	b=IJQUL8qkc5dsSBgOAqiQBvWyNfYtXc/uDnxBC4IqwkHQXFqjbMWy7yL8PDNI2nYjMe/f
	 WxvSeu/GB1A8dpPneqVSX7djH2T9Iq16PlllUgxLiQLpvv+ICaljthWaqCER3idwPBlhE
	 g57pW0EMzycyItWJxwVDLov8/glWSuLieDeiOTItBsmNT7IrWnE6dvxkrh+r9h/djkCT2
	 gFJBIEkPeu8Zz92yIyX0kOqC7ncZJG44s2VYcjKq7OQNmPriY+jMhAM112GV+8/Tc1uCS
	 3vmpj8b1TcU8WmbwemaVeImcDRTQnFLx2uSJGtsamG/aT9uFFcde6UvoGWY4qWDKgMQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411666;
	bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NVLXEkL+GAv642LgSd8M3kb6+edBt58yam3QOZfoN4TU8n69hZsC+t0emuK7Vu5ex
	 CryJSQojniNA9Ov50dr4rnX0TE/SKDJfAM6ltRrRxNJCJaqUn4St0hGXTFQM62z94o
	 VsVavIa5YpYulAc5LlmvvYuOJZ4kfI6xQUpKSVjYnyOKa+P+uCUgcv9y1ZoJgISr5C
	 FjomsPaOX+VdESogTbZilbJ94rNfXe1kZFkW/Tv9T+k5rcQmLnii04zOqHH/NYlaES
	 V5592QH+zHXiS2jgDRKctztv/+UQ3AKPpMybZtgNwvEAZyDyAHaiy6Kf1P5ExN8AAI
	 ddbxZ41MGbvHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33C3F60634;
	Mon, 19 Oct 2026 12:07:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2358C1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0999E400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kQifoUVcnSV for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48FAA40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411664;
 b=KRiFREsi4XzdpplJ4eZiZwWQdXTqNSuOW1ErTB/6rbs0Jb+bTg96nMCfBy6v1Z2mlXPV
 H15/8rkoW/AEK7jVDN22b/Q8OKNvyw0MYkSmtR56onyrCrkXa0wfgdiYg/rzoELrqb2mu
 K9IuP7hpMBH78Z9ojfZubWBqe/Vn8NHxICB2lKq5O/iR/BcwltsGl+Vo0hASnrhHHX2G7
 +tbm/mGXdbbXjYJr9MNXkONK2BFVkyY8DN75PVR1TYjq+lSA2vN2ZWakYcmRUPljrjdW5
 k9aUUZ0uJK+/+gtUGE4tbyBpDuh6557WYsZBIkfoOepaxrjjjbi2qHAj75F4nU0Fe9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411664;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
 b=Cjn1paHxNC6HlG5zwzfl2r+MaY+Z+nS70x4+xopzj6qec90VKiT2/mjWv3VtFAMl/th1
 YjuW4jNJsjIQ/bQtDZrD5Ep0rlj8BfyYkUlF26188cUd/kfu61jCEmtrbicRI25iWnkFP
 rIe8WidKdBZNmBEiHbUq6/BNet9C279cn0cf8aHAOohGLmPAW1oNK/nLUhFLyEHtgMcWs
 xTHeuTjrU3JhmLMynCwynJvG9GEC2JPBG+nX1/6sB71Vm1fy3Ulz6d+3CTH4rQz4XkrxB
 16Yb5eyBoAor9U6C8/asmvg2tuQA1uoQ/OmhYbyhXjkCdP730A7G0nFij5Xm1Be/GWA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QKUF7zl1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vl7bYKWj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QKUF7zl1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vl7bYKWj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48FAA40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:07:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuJO1348224
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=; b=QKUF7zl1OexHRsky
 YdxaW28tcQeUcB7f7AWW64RAeYhDbJWLNJzFp/0tNaAB25vuo6zCAKl3T8ddpXve
 3DNnv6WPY88atwPcxkXIIbVipMMfQBvdLM/qjP/cSjJStXNkAq1XYbLFviZ/dAc2
 I9MDx6M12bpF0Ff4UbaP0Z6Sc9kDPsjZOS5dpFAmbHV3AvrJOLlNJTxtknhskDK/
 2SFSKvlOXJkDllJjxp030uCJzxbeqrDBHBAnWNZ5Js3GbbdHLH9DpjB0IgM2pn/M
 VyDrVtfjt52kvQyVjmZQipCTSKK55olOpfUdVyaBpFLp17e8YmYIpbQHGwwoqIti
 qR83gw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgyc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:07:43 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8200c815489so22427507b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792411662; cv=none;
 d=google.com; s=arc-20260327;
 b=KizNZ+VeAcP6Zc5G0Xx1rCgrbWHyK46Ipq+BGN1z0vRPe8etw0Z/R8Jy12HQL8Yjrx
 l58rJSPXn8feJqyyrzUydiGDmKiTZiIXQmU/4JccvSit3/8WT9T6Voy5vo8npLMMDIiH
 /OVqwuQLyIJ7DLCtxbPP/IuQbW7Cann1mCSQ9vFuO/g9zng4SAiuPml3UvtD4h4dbYnW
 FJayEPXsx9p8lXGZuKfp6H4/303xNi5zEixf4lTBh1HIepMGYpZMtT+iisfAPaWU0fU/
 TAcLftjz5HuEIYtEA5FglcEB0SzM8wVMbUqWOO63XgxXfIc4j1aow0Bbn0weOv3btgW0
 fCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
 fh=i9/SgGtsL1YneY+55J2+fNQ/znD8XWYmIK8YAy42Jj4=;
 b=bjBcy7WbznRoPQ/73HPfImuR7minoQsM8oZthAKbKGv7GV2FdrPSlQjLArwh91YO/J
 wWJ3z2tc6sbzPmbsg8jLCsynAdOE4T+DrXI33tigY/sAO/E/Q4Qr/RezckWzB++qjKbe
 sORMoDpB+bKd9Af8X2oetidqLPCIL5H7MsCTqje3VhCus8lKpbaFT6eDE4GGUfAUkga4
 EtQoxr1VQIRghXpbNK/Kl816bHsES7S+5eZL/MCzxOcGD2cMR25X0khmB6+1mf9T92r+
 H3oBC1fQERiXlDSivkCulaliNC1itFhyiHjxYeQyHaT2iyBry2nxzM390gJXJYuVSPuK
 gqgg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411662; x=1793016462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
 b=Vl7bYKWj4VDlrryqHQf4FYzCMx4XXgzZPJ8dl1mdWeA2UMMWQROZjjYgyrTYZfIngV
 +Es+OFvVp3mRVdGJqjqZR43YlsLN2vw0Qmxe82Q7zWpv3E/9EcJ5XwPQ/YZKSCsKY2gf
 QxL4FIitMdfZD+vqXQcVPhbkrcElHcjwhWrEDOdrrSU1HQvvqEFvMO0OqzcvZ/0D27kE
 eM+uc/wA0MsaG6C/4kKECh+5ayl/3gRUxHzlegYRyoIcUHAcbJPzNlgJG3Undy4E/tHd
 +6IFOjNb+56y7a1MTskd5WnO6YT9ir4n1BE4k1pK5+8ioogEK0wDKcObbB2lud4WufZj
 l8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411662; x=1793016462;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DUPaTuw6Z/33BJw9kQ5GJ8FL6JiaZhCANIKJoK+5mmY=;
 b=pbrjrgEOzkfX31Q+x+MvInAiZkYsZSo+gzAXs0Z9MqExgN5FToCnkDc8UGwzUUaChk
 qRfT1sHK7FV35f/RfLq5PIDfEyd0Q6zQwrM0m4hFitrmitctLij60eex7Z34Ke1AG+Ao
 jHXSWpPzDrdLO/9fyetK2qT+yVDmSsC3PTGz0JueLKJmmQ4YLVA24+x/uIXklVRveMfC
 FEw8PdP+exBWoNS+RvVGWtMwE6ZBwIRKU9EWV9m5e0tiqWgWRUlCROhaGv9maeIR7HnM
 JCS8Hjcnn69/Gp2KnlVFtimD1W8b4dZiwUzJrjdunRxGB+ZPYpbNExEu24WcEQVB6Zq0
 vKwQ==
X-Gm-Message-State: AFq9FYIQCE2TJjzf3/t9EzrX3s+Prcy3uGmLvQJaxwE7S5Q76sGVbmig
 67U6i1vnDlUzB9Z4LKH9W6k5Y/XQwtoTSUppvQcHA0Sa0OH9p1VdcNeLwBJxgNERKRdpJh+nmQG
 HPCgrNcxEcE5+dal3vN6sV9l4xfkVkgCHVALP7xHYJYCsU+kHK9b3xJzNAUlAEH8XqPejQlU9Fb
 L8zCkZEaguYxi9PocHWXa7oGvVBwbPpV4WZpb3iAQbFUlNow==
X-Gm-Gg: AYBFou16P7yMv2I8CbTbcJNnAX2BvCsp6NoEuDfc8rmReqPFoCRdCx8pRfwc+i2QwjE
 XxaoZuZms86gq0dAAfg/NT0lI/Zg+sWpEJBNcLAMW1qzlfDLDxm4W2yVqcqluswOBAfxdd8Gffh
 G2rPozzc0nVYTDKCcqbVhIBNdmDB6zLTJo7MuRo84e2lvJ/PH8PIJWDiGsQA==
X-Received: by 2002:a05:690e:1504:b0:677:b6ea:9666 with SMTP id
 956f58d0204a3-679ca83740bmr1493866d50.56.1792411661881; 
 Mon, 19 Oct 2026 05:07:41 -0700 (PDT)
X-Received: by 2002:a05:690e:1504:b0:677:b6ea:9666 with SMTP id
 956f58d0204a3-679ca83740bmr1493860d50.56.1792411661336; Mon, 19 Oct 2026
 05:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
 <20261012-upstream-optee_rpmb_b4-v2-2-85d76a54273b@oss.qualcomm.com>
 <CAC_iWjLJ6_mVq6F1dizbJ7ouMeuhKBg1mEX1q3XpJvyeLjWK5Q@mail.gmail.com>
In-Reply-To: <CAC_iWjLJ6_mVq6F1dizbJ7ouMeuhKBg1mEX1q3XpJvyeLjWK5Q@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:07:30 +0200
X-Gm-Features: AclHuK9idrA7p2k2CdvRT5qPUpIKxxGkrcvtm0hsOyx0OEqjRQJr_FGdVN5p5-c
Message-ID: <CAPzfCAajeeVor0QH8PRrsdS4vaENDBBbmYp9qQtKrZrvvUQQbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MRIuetkO7GahgDfHcylyT2P0WBo0sQug
X-Proofpoint-GUID: MRIuetkO7GahgDfHcylyT2P0WBo0sQug
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad6080f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8 a=NusAsiRhZXnhQsvf5uoA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX0SjlL/dlLYlG
 Hn37+2foY1TRQRNgHl0u/CULDgNjoc6370qs2bqJgnUJLliyNVGFqPZAwCpOeWuE/CPLm4leOZc
 kuiKWXMiIfqX7+YPq9FxBRKv6XTHstbbnZipT1axYGdmRjwieFq1vrTJ8VOPs7fV4QNdMyc9vGI
 VOwpS2rHkmhZwP/vquek0OGWz0u0muv4g7hRwMrB4NsaCyj3dqzUALfDiEfwqOug40Hdqs0MoiQ
 znMvkP3iPVhGOhEc7jZ5vD1FoD8wGdEvoOsZFE2/mVOgniMfazAG6Hpq2h9N7BegBtLtFW0sn9D
 Lbcl+kEFnWSpTEvWCbQ010+toXXXjSz1/gg759G83L31N+5pfknNXzXB2OgVDRq5N6y0NNAxXEE
 NrqhxRjwM2HpeJlunRWJFHAlCCyw4sDMLycfad2sbYiX7fOY0d+aDcdXiSVHbn8pbiF0nrAgHjd
 B99IhlOcMZXZ0mLQhcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX4jtHuvsuQEhJ
 yIy9QUa9LkvgIHZe4iwFrkqACIDm2ulHtu+v7RN8xEaxppB+bGtlkVJL6e8NSpkv6mhVPkUi83R
 f2ZoKfi70UBZpMrRa2ebiVNBiPxwqn0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190048
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

Hi Ilias,

On Mon, Oct 19, 2026 at 10:47=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > ---
> >  drivers/tee/optee/optee_private.h |  2 ++
> >  drivers/tee/optee/rpmb.c          | 11 +++++++++++
> >  drivers/tee/optee/supplicant.c    |  4 ++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index daff3e04493..92e3b3bea10 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -42,6 +42,8 @@ struct optee_private {
> >         struct mmc *rpmb_mmc;
> >         int rpmb_dev_id;
> >         int rpmb_original_part;
> > +       /* Non-zero while a supplicant RPC from OP-TEE is being service=
d */
> > +       int in_supplicant;
> >  };
>
> sandbox uses a different private (drivers/tee/sandbox.c). So you are
> overwriting ta_avb_rollback_indexes in that code.
oops, nice catch!

That is a v2 regression: v1 kept the counter in
handle_rpc(), which only the OP-TEE driver reaches, and I moved it into
optee_suppl_cmd() following Jan's suggestion without noticing that
sandbox.c calls optee_suppl_cmd() too. Will fix in v3

>
> [...]
>
>
> Thanks
> /Ilias

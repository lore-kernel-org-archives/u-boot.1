Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F00CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F27C80854;
	Mon, 28 Sep 2026 18:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEy83xci9TiQ; Mon, 28 Sep 2026 18:28:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD050808FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790620126;
	b=J7V309OrfP9EnZRdrHZsOc5bpCkskoQpsiF4OjBL3YY4aVhl9DaZPCxlAgIPsA++mycX
	 m8PtK7GdeMvKq8OOX5nN5v5BOzL8w31TvVJS35639Su1Xi7h6jM0zQ63rFaZ5ePvgnij2
	 ay10bSVRqU/LQSHq7fBIBoo44iUfvbycpvbmWWk4sB31CxxCPAzR6dgRC/qIANsRZseHb
	 75WxI3ULN0bFFckMhBC0Z3oe0roYbuI1CkzX8Jpu8cAUAl7PuDsHtN0LBxfP9Vz9JLnPc
	 TBDxZyNrZgLMimglfmehVPZmYa+g/Qxa6dltQKhDiic9a1XE/d4n88k6raLsQcnl0ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790620126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Content-Language:To:Subject:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=3aM2Tf87fDaYXtyagCdj5uoJEf5sTCrTqN2uXK92OdI=;
	b=DBfK2jln+0tJPSYd3s4z552zBmoHzQMcybKhoys7ZknsY6U3Mro/KCIor9rNlq3IJMhr
	 PbJNG//X9DAueowZ3EvNbO/jpRfGDOzwuEkL3ccEq7MIr/JmrBTS2xIean1gz+Ab3svrj
	 p03C3DOctIum78e3xrUoUI9rcQCivDiovZIdrxI6NtHU1suiA7VdwM0KyDEyfxrB/ryqh
	 l8z/QXVRNRsAcmr+5XxfvUB3d+/kuj37JlgwBsmwFV33TcrpvG8oDGq/V7gnIAPPubYSL
	 gXwbS7wd7EVS1RNAL8KFq9cetO6HINAy/I2GVtoqQdecyzWsZmzilWc1fSLnSfuWuBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="P3BOSa/9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790620125;
	bh=3aM2Tf87fDaYXtyagCdj5uoJEf5sTCrTqN2uXK92OdI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=n+/bC9r93zbTe1tgS1Rv0GOFI9w7ewaNZMnn3cFfImUA+NAov8A+Ot9asRWW+RbEs
	 DdIvbLBscknju+x5N+/HxLPd7KL/Bg/MgKPXP8k2z6Gjx4XgpH9/nICRT+goxEEztZ
	 G0FCKx9aVssbqhBaJQ1l+qIfb+H8Pp9tRfD7raK7Goss1GQuuCo93lA9oxG52/g6Eu
	 Ol/LCsQCVsr+t29Beby2RDofzi1sS11MycOo/nZ2H9jsLeiLqbC+rFXjp+QlE0/fAG
	 MbQYS8lb/dMV4PytrfAFh6YaBIUSRzTObx+K9MUR4t5fZP7wkDuoRXM6wiQ8ytA5S9
	 eNeLbn+hIkeuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD050808FC;
	Mon, 28 Sep 2026 18:28:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24C2DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B25B80859
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Twhch-nsG8Z for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A41BE80854
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790620123;
 b=k8aJ8nK7AHDsFyAisqdqXNLutYxQkr1qnI2s30LeHy5VznM1DVTnKHWI4EnL/D/PJk/7
 EJT3xqz9RdGwjVHoj0gTrUq3ub+5z3LccRhhAj1pRkCbRjj5n2Ne28+l9zL//czqnIwHi
 eYgYpSdt8oWNZz1hcd1amPiLpEwPyRtDQgyW5K0d11FDwdTtuRIfEzJSCaID5a/dxscqr
 bxaGyKyUphIujmwAj5iTpJ6gpt3w/dYiJDtF4Cozzl3SjgEJxpD8BFI1X1Pq7DD+EtY5C
 5PsTUy/nRPSyTIRP8308Dea65e2EMNUN03tscIcK+qj1rI3eokD001zrMwCB8/siz+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790620123;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Reply-To:From:Content-Language:To:Subject:
 Autocrypt:Organization:Content-Type:Content-Transfer-Encoding;
 bh=3aM2Tf87fDaYXtyagCdj5uoJEf5sTCrTqN2uXK92OdI=;
 b=FYTfWcA2g0y67IElets+IMG5N5VsHEULp7NXG03VEob1M8zvW/zH6tPHFdVWx+paHaBm
 b+NrlEcvows+lFFTV9VrBtrtBlOaYlDFGe5MWSzMpmyedC6SvgA/UxfQf4i7L/AcVtdXW
 8LeksAJ6IaGmf6kF0ew1L6u5p3HGwtqSC/h6uOe40uvEB4y1RjNyZOcGQ9FVLIYxhiqCS
 P1uO3J1PQRzHAAc62sFfDVdpkxf78mcq6E0s2kSo5uq4DrYuvhy1UV0AIhVYpAQprk4ji
 ubeXJuVE9H5TuLHFg3qtdzpH1fpw+MCLbQd2hN75/oFD4Y8ireHQj0A9MRui4t3fD5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="P3BOSa/9"; 
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P3BOSa/9
Received: from mail-ua2-x10.google.com (mail-ua2-x10.google.com
 [IPv6:2a00:1450:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A41BE80854
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:28:41 +0000 (UTC)
Received: by mail-ua2-x10.google.com with SMTP id
 a1e0cc1a2514c-97e7c8c8602so1849577241.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790620120; x=1791224920;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :subject:to:content-language:from:reply-to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3aM2Tf87fDaYXtyagCdj5uoJEf5sTCrTqN2uXK92OdI=;
 b=P3BOSa/9V4SaAa9bHSXs1r90e/OVsVAQAv7MJsEL4ibF64aPebx+xex8qN77Cef6DJ
 1mTP9r2P7dNZpwQQKD3HgtD2wU17aKjv2ADAs3LQCPondeSgC1mRuoNY0roH+7o3Lk0S
 AEXuulf9WjzvDfevsPTAFG9ClfUTLWm//fr2taboXcHTgfdTaV1gQmL/9gwJitncuBaV
 wzVduYdLmNHg0GWXgZirE6KxG/S4/J5AVjoZgAuPKTACmdFGd94Ye48tnt85WbnU6xWI
 /HvFDhUk46Hk3aDB4H2rtTZ8BB1a05etalg5t/0cR4E2rxF8FxGZOzuxKAJ4wQz5IjLa
 f2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620120; x=1791224920;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :subject:to:content-language:from:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aM2Tf87fDaYXtyagCdj5uoJEf5sTCrTqN2uXK92OdI=;
 b=MjOgV3/zlkxAqIYDoCt7GnnqaZ+O42DSbybAuAKcL/u65XcfywuIfASW45X7m7C/zS
 sCNL5F3Lh+MT5ajgpxbrf66YICN14idAtGNLfTbpsNwljHvAiJcWb/SOLMDkiOD1hooB
 uh3XofeUFlQm6AcZBEskP1Gh3A1ZiDHf/bVgw288eaZnygc0+RsaCc4Ik8oGjBhkIDYB
 5AXpQ0fTKBEIeIimaHvrZt/92e2vU6LxBFqUW9By095ln+kkQ2DjzHuQxv1PjqFFzaB4
 FaPiWCdmt38C+NQfTuWFE+6Uc/VrJ6YRc7C63sGLh3PYMXi3AkHVM2a3aS4VqqAa2pr6
 nCiA==
X-Gm-Message-State: AFq9FYI63SSjyJkMgmrCvT0jblRsmHbKFQd/Et6mJdHfpGP1hg4cTwOt
 rwg0JmJEnJjxcdGIku0TOoUyPXyylFtmYSTwAJ28jL8dbPtKm1Tllxb+y4cP7RvCMx3Oyz1V5cw
 r/1BXnBc=
X-Gm-Gg: AYBFou1KpZsquG+jqtfGsePUG0zgb4XSXZrEyFYl+hcaJw8g/TNDEFuSV3wSNbhv/j0
 0+u3FdssCmd+Fqt/xfshS+WQGrqOyigVdFNkHmmdknVQjugillcQ5CgwmcCd/YUyw1gnFULat/d
 bWgNgwjOXJ9v2pMrGFqC0eY20CFu1iknk4zzivc6NOTwCFwE/z8uPt6gSl7hJx0I4h0v4HmYq2y
 zy1j37BPpfoSsQszueSKm7fPHiHEsEmhH9N9w6EpUUDiAiPRzoWA0Y4bhIAg0988CW0YKr7ZGwx
 ZtwdKSPSasuof5u9S6yAuxyJhAHjXgrl2kCLkZkqNO7nenJwllDwxQwUtFSap3mNfroRIvB7BO3
 mCRzX+u/wy++F7a+Am5jm1sii/KAkkvuVYni9k7+kx9a8GJIR2htHOsNagGWSqw+LYMfuFU09ZR
 lPlCVZZZe0ekole8KdZcPkjRFZ9yAZ3wVThCyMGxCzJYZKdHl8C9RRaI2chQmtYLXxY8HXSjN9z
 0xkgbkGbYMMIZY+/ZTjR67yc6U5bSiFYRhdo32kS07yeySDxCJ4Uzcd66wyNOQKBTEmiivAmM/k
 bYtKKQ00MKSnVIYZeA==
X-Received: by 2002:a05:6102:3907:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7af1c6914d8mr6033597137.5.1790620119744; 
 Mon, 28 Sep 2026 11:28:39 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9889b0b36fcsm7526022241.7.2026.09.28.11.28.38
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 11:28:39 -0700 (PDT)
Message-ID: <dac81055-ff78-4b28-9539-ea533c12cb33@linaro.org>
Date: Mon, 28 Sep 2026 20:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
To: u-boot@lists.u-boot-project.org
Subject: [ANN] Meetup during the Embedded Linux Conference / Open-Source
 Summit Europe 2026 in Prague
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi All,

Next week, during the Embedded Linux Conference / Open Source Summit Europe 2026 in Prague,
we plan to meet up on Thursday the 8th around 19:15 at the Krušovická chalupa bar,
which is a 10-minute walk from the Conference Center.

The place has a large variety of food and drinks (menu at https://krusovickachalupa.cz/menu/).

Please add yourself to the list at https://pad.sfconservancy.org/p/uboot-eoss-2026-meetup shared document.

We will make a reservation based on the headcount from the list, plus a few extra spots.

Looking forward to seeing you there!

Neil

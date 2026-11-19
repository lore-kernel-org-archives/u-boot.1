Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCF606A32F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oXc7lzqD;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X9Gqoobq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E4C3814C7;
	Thu, 19 Nov 2026 18:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dR6x5qKwxi5f; Thu, 19 Nov 2026 18:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EB6D814BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795112136;
	b=Xei839v2Uk7/qJzd4PPkdh3a6zaU5a5AfoNzsblbt3WJOpjTJmJK1WSlcmBkAvDk01Vl
	 tJJ+HOs7DtumR5zmGjBbXHcpN3pVLpEb1FS7baTEbhSNZVT6sWDMLpoXkR0M452AQM2Px
	 +utXztXB3d8JF9bXpDvv4epeRHQJHYC5+B37s6G1zJO11DZhXWCK9eqiQyUhbet6cC/XA
	 yaZkErquK2PXrALtCvZ5WbHwKsOQhpnInw/dfVKu0lELRXHeUyMdBtvmT4WfZ9XQBljtZ
	 NZkAVAKUQDwomV2CWOzsbIB59Vwy4Coxk6gkbeY3hWtLApLGJixx1/E1bEl+Upj6WKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795112136;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mgFT+mOnP9889oDFDAulvMpBHM3TBlqA9HtP29F5UEw=;
	b=I0VypS4fYgkMUbzIka966V8GYGmkEKdUPSJNg91qsYFOfnyXJqxk4hYYRPVcVMP4shCq
	 0I2ATDFtdy5fEHmXmg4t19PwJ0DuVtxlaeD6qpMBtVLvW5hoW7aEY7tSty+wgM4mQ5lVr
	 UxQPzB456H0E5Lb+kcZ0uon7mlkL1EkR0PexDEuArUqJIHi5P+7VFd+wWwAvPAGpYTywF
	 GHgTw2gFpMOFZW3qOlREigiWIzhjJhTHJvSf3nJGQzWrEp+IaDdJ2RQd4TksGwYd3N+7g
	 uNO8A7DXVxK85JJbBaOSh4ERMvgwAehR3BxCxiXzHQ0AONFSCeX6uHeU8MebEOHK6CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795112136;
	bh=mgFT+mOnP9889oDFDAulvMpBHM3TBlqA9HtP29F5UEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oXc7lzqDIGPjqK5218tMVDvvbwW2wwk503aXxS9KMKvPnjNx5287jZ8MbperKGO7B
	 qBgcwZefOhExckbsPjcLJxSYaO0LIkmrgSBMW6eLVD1tNa+ss6IvQ6EljYEgftCfkN
	 wfqt88UvEJTH1tEay7X0SdTtaoYc+xADHsjJkBMo7/3PBoaU85c/b6iL0GIPNv0zaT
	 5fzxWJMKB4e+5a6JrMhSTOwBoqYtTjFeqBfXCoAyhlz0bVvqP+j+2o9iL2GTSVs7xn
	 HmZMcQp2FbXJ4UDERMkZZK22zeTvr7gJuBWn+eNw9nY3XwrIbOQzj07E8YnW5fBNWL
	 7UedpMlQKv6Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EB6D814BC;
	Thu, 19 Nov 2026 18:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA58E465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8337401FC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4KibBJfTBv9 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 759BC40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X9Gqoobq
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 759BC40080
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:15:33 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso35771595e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795112131; x=1795716931;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mgFT+mOnP9889oDFDAulvMpBHM3TBlqA9HtP29F5UEw=;
 b=X9Gqoobq/9pHBFgNzwoiEVcoObI3LMLO8qQQjFdtsK0/eYkRL8CQlCS7y4JTfOTik5
 ExzPrgjZeneXEX6WuTPV+QeJ3pbn1soYDh6v3px68FNrkTQ7cD3kwu5LRHwM5Xct5Ve4
 /Co3oKAVqiAKUDzBp3kImfSwyEmnz1rU53RTBOlBt3dJRgF88JvMSVmBVlct1ezY8SlU
 GX5pznlQPpuluKHyvOkFg2L3HCVOTueYj6Bk9RnExi0UdhG034fBYZ3znyQ11XNF3eya
 1yHMOhjLBQIJlp9qlWTOfgDmXxwwNl4B6XsnJ+Ft0ALcqAFCpGenArdVLir4q2CG9KLB
 ng7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795112131; x=1795716931;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mgFT+mOnP9889oDFDAulvMpBHM3TBlqA9HtP29F5UEw=;
 b=zA6luVko7Hx6q3FwH9eVGc7jSrgPOd8pIk2clpn6Slw8lH22EG934zstfbYhmSU2yo
 VFI5vfyANWwUF0Wevx4NQAnq3SCeFA6vAk8VBjCvLcy9IWPiJMoAI+K3Z581i6UXkMIB
 e850fjpbkJZteplpAR8rxTTjEfxUO5yw67x7hw/a6XwbLDtKg3jg0YKWi40i+NO9XGRO
 ccQGCFgMgQuSUM4gWrSdIMgHlM1dvB51Q0zA1BhhSg2ahjMajaRjmzS0kPzt5FyT8xvU
 8vgII+TpxmW+puvx6bZPCiBhsnlPTdDj6QWr4wutQZZKh+6qWEx7ZONILDaI8c6GhJwz
 r2jg==
X-Forwarded-Encrypted: i=1;
 AL+hErHtx1fRIO6Hnef072JTh0fs7/JuyQLxfr3AECk6kYBMX6wHBUjzESC2ZE/aPYfnP45nd7nxO6A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z98yZI9xDO+FGL7iQbv2cfVF5zqXkr5tRd/HFXjjyNRVbIKAtlZ
 ezmGITLBWv1PzKEyx/eJNVijrqgvvsS4kq5jf/UYw1r8S95poGxBjteN30+YK9WnYBs=
X-Gm-Gg: AYBFou02H8PZzSwqwmJuHs176PeYcPhIW/pu/8q/uh3MvYYnaL6yEZoiSofp9+o2hwg
 QcSiWmYaVgKgPhhl/I+JCpJUXWeWtV76/fHk3q+NXOHSy7AoFFufsv+WvtQgeB/Eght71MMez3W
 LpZHZ1ipYRn/rQ08VR4HCUBNBlp9nFykcIKwgxaFTMPBepz//EEETR8+vGwpcYdynHNtvNugr2w
 V1MNdIu9um9hQh4JnUZXMHO1dKJh1/ilqoOJ0w/UcmYBd8qmTxUM6NjqICCZ32QsHPHFDE7jc3e
 VHaDAKPd8iUCIkAjg6MowfwTbSwtyyiPLGeGV3uy3+DPA0E3MMe/d8F1LjgJnuV1HdhanDXEWio
 28G/Cllo5p0jBXGeqIw76/+zQXbCCXU4MWjU0eIYPWftOCUpjkk6O9fFpdfVy+mU4Mx82iCjrWB
 qvs6193sSMRiEMAd/wFTkTDX0GtMZD/ynXVxWH5qaaLOr8Q8JRZc5pdiO6sTaRyiQJD0teL+zu2
 VsmgfVAY7F3Lwrr8txjcuDCHE2iWKKuhq5rKD7mk+vWbzgO4nEtPH6AUKRKzDCrQ6nDnq1hel5R
 5jctKCDYtuZE6NbdFK0UdRe/01njmZeioqj34FkTOfKZcMUSOK+UB3o3PKKFesvUAQ6ssLUhNeo
 Rj46DcXQ=
X-Received: by 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4bb8881e969mr6958715e9.28.1795112130434; 
 Thu, 19 Nov 2026 10:15:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:678a:3519:4af3:27da?
 ([2a0a:ef40:ee3:3401:678a:3519:4af3:27da])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm1063616f8f.44.2026.11.19.10.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:15:29 -0800 (PST)
Message-ID: <078dc2f2-f7ac-4741-a683-c35d4ecc8296@linaro.org>
Date: Thu, 19 Nov 2026 18:15:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] binman: Use mock environment to ignore DTC
 variable
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-6-b6cf7e96944b@linaro.org>
 <0ff5c700-9ad7-4aed-8309-aa40e6e3cab9@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <0ff5c700-9ad7-4aed-8309-aa40e6e3cab9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 19/11/2026 17:13, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/16/26 11:59 AM, Andrew Goodbody wrote:
>> If the environment contains the DTC variable and it is set to a relative
>> path this can cause the tests testFitFdtListDir and
>> testFitFdtListDirDefault to fail as they change the current working
>> directory so that the value of DTC no longer points to a valid dtc
>> binary and so the tests fail. Instead create a mock environment that has
>> the DTC variable removed from it just for the duration of the test.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   tools/binman/ftest.py | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>> index 567ffa96b2b..50fb25325a2 100644
>> --- a/tools/binman/ftest.py
>> +++ b/tools/binman/ftest.py
>> @@ -7984,18 +7984,26 @@ fdt         fdtmap                Extract the 
>> devicetree blob from the fdtmap
>>       def testFitFdtListDir(self):
>>           """Test an image with an FIT with FDT images using fit,fdt- 
>> list-dir"""
>>           old_dir = os.getcwd()
>> +        local_env = os.environ.copy()
>> +        if 'DTC' in local_env:
>> +            local_env.pop('DTC')
>>           try:
>> -            os.chdir(self._indir)
>> -            self.CheckFitFdt('fit/fdt_dir.dts', False)
>> +            with unittest.mock.patch.dict('os.environ', local_env, 
>> clear=True):
>> +                os.chdir(self._indir)
>> +                self.CheckFitFdt('fit/fdt_dir.dts', False)
>>           finally:
>>               os.chdir(old_dir)
>>       def testFitFdtListDirDefault(self):
>>           """Test an FIT fit,fdt-list-dir where the default DT in is a 
>> subdir"""
>>           old_dir = os.getcwd()
>> +        local_env = os.environ.copy()
>> +        if 'DTC' in local_env:
>> +            local_env.pop('DTC')
>>           try:
>> -            os.chdir(self._indir)
>> -            self.CheckFitFdt('fit/fdt_dir.dts', False,
>> +            with unittest.mock.patch.dict('os.environ', local_env, 
>> clear=True):
>> +                os.chdir(self._indir)
>> +                self.CheckFitFdt('fit/fdt_dir.dts', False,
>>                                default_dt='rockchip/test-fdt2')
>>           finally:
>>               os.chdir(old_dir)
>>
> 
> os.chdir() is not thread-safe as it changes the cwd for the whole 
> process, c.f. https://www.man7.org/linux/man-pages/man2/chdir.2.html
> 
> Nothing your fault though, and I don't know how to properly fix that.
> 
> For this patch, here:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I'm wondering though, do we actually need patch 4 which removes DTC from 
> the env if we properly patch the env such that it doesn't matter whether 
> it's present? If we really need it, maybe moving it after this patch 
> here with justification that it's not actually used anymore (and was not 
> working before anyway), would make more sense to me. Just nitpicking 
> though.
> 
> Thanks!
> Quentin
I am happy to just drop 4/15. The patch was only there so that nobody 
would think that the DTC env variable was needed and in general stuff 
that is not needed is best off removed. As for ordering, to me it felt 
better to remove it first, which fixes both issues, then make the tests 
more robust. But I have no strong views on it.

If you would like a V4 then please let me know which you would prefer, 
to drop or move or just leave as is. While the rest of the series has 
some minor optimisations that could be picked up, 4/15 is the last thing 
in need of any change.

Thanks,
Andrew

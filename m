Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD9D0E6C6
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDCB8404D;
	Tue, 25 Nov 2025 15:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BWUBOBpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841B0840A2; Tue, 25 Nov 2025 15:52:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8055184011
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dG5JT2rWLz9skd;
 Tue, 25 Nov 2025 15:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764082345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UGH6BCyLYeh/Y54OFZ+ibOUG2f3qJR14nbHcd9jtp8=;
 b=BWUBOBpTx9ASdm32oXneACqfoL5caYsRk9C9yRaHTPbFCbNQAnaZJjNNn/k7yJ801fWxfA
 HopIuLmrfG8EaOliV2chDDuHifRL7tP4FxuG1bxtDCgB0xhEPndW9QpENFdLcDg5Ds95fW
 q3PWEDL1EK+EzzQI6Gpad+l2fcnv5te5Uowl/xFWIX6HWtcF/HDVTjCYgKzUDK+VViGF45
 hleeTlbCbZ9ohCDOLiWyMmg59z+f/EbISqVQTmtAKkC7c/jw4Z1cGRtSICUcjmWiCwxSgp
 NJ7jPdnoX2a/1ZQgICRPACvSiEcQQqlTmpVowFGfSPJb9fFnXTNRwTDa/HFCWA==
Message-ID: <15d914ed-15ed-4acd-b6b6-cdce114770dc@mailbox.org>
Date: Tue, 25 Nov 2025 15:52:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] test/py: fit: Deduplicate the test
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
 <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b36ae9803152b0b0063
X-MBO-RS-META: gfqzodmyyc9mhu69qkwh8au5zc4wjdn8
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/25/25 11:50 AM, Quentin Schulz wrote:

Hello Quentin,

> On 11/24/25 8:40 PM, Marek Vasut wrote:
> [...]
>> ---
>>   test/py/tests/test_fit_auto_signed.py | 98 +++++++++++----------------
>>   1 file changed, 39 insertions(+), 59 deletions(-)
>>
>> diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/ 
>> test_fit_auto_signed.py
>> index 0b5dbd5401c..3895e7d9369 100644
>> --- a/test/py/tests/test_fit_auto_signed.py
>> +++ b/test/py/tests/test_fit_auto_signed.py
>> @@ -138,6 +138,29 @@ class SignedFitHelper(object):
>>   @pytest.mark.buildconfigspec('fit_signature')
>>   @pytest.mark.requiredtool('fdtget')
>>   def test_fit_auto_signed(ubman):
>> +    def generate_and_check_fit_image(cmd, crc=False, simgs=False, 
>> scfgs=False, bl31present=False, key_name="", sign_algo="", verifier=""):
> 
> I would have grouped variables for the same "theme" together, e.g. 
> simgs, scfgs with key_name, sign_algo and verifier for example. But 
> that's fine as is.

They are grouped together, this way:
- Command
- Checker switches (crc, simgs, scfgs, bl31, tee)
- The rest of the params

>> +        """Generate fitImage and test for expected entries.
>> +
>> +        Generate a fitImage and test whether suitable entries are 
>> part of
>> +        the generated fitImage. Test whether checksums and signatures 
>> are
>> +        part of the generated fitImage.
> 
> Would be nice to have documentation on what the parameters represent and 
> what this returns/raises. Not a blocker though, I see we already don't 
> do it for other functions.

I am not that deep in python, so if you could tell me how to do that or 
share an example, I can do that.

>> +        """
>> +        mkimage = ubman.config.build_dir + '/tools/mkimage'
>> +        utils.run_and_log(ubman, mkimage + cmd)
>> +
>> +        fit = SignedFitHelper(ubman, fit_file)
>> +        if fit.build_nodes_sets() == 0:
>> +            raise ValueError('FIT-1 has no "/image" nor "/ 
>> configuration" nodes')
>> +
> 
> Only downside is that this exception will be raised with the same string 
> for all callers. We call it multiple times in the same test so it might 
> be difficult to identify which one actually failed. We could try..except 
> the exception, use the content of the exception with
> 
> try:
>    generate_and_check_fit_image(...)
> except Exception as e:
>    pytest.fail(f'FIT-X failed: {str(e)}')
> 
> maybe? (NOT TESTED!)

Maybe it would be better to simply print the test configuration ?

Like this:

raise ValueError(f'FIT has no "/image" nor "/configuration" nodes, test 
settings: cmd={cmd} crc={crc} simgs={simgs} scfgs={scfgs} 
bl31present={bl31present} teepresent={teepresent} key_name={key_name} 
sign_algo={sign_algo} verifier={verifier}')

>> +        if crc:
>> +            fit.check_fit_crc32_images()
>> +        if simgs:
>> +            fit.check_fit_signed_images(key_name, sign_algo, verifier)
>> +        if scfgs:
>> +            fit.check_fit_signed_confgs(key_name, sign_algo)
> 
> This is a typo.... that already exists in the code (confgs instead of 
> configs), so "fine".
> 
> Mmmm, we should also verify the signature of the configs, but it's a 
> TODO in fit.check_fit_signed_confgs(). Maybe someone will implement 
> that. I think it would be valuable as I would expect most should be 
> using conf signature instead of image signature for added security 
> (though I haven't found articles about that but I'm sure this has been 
> raised a few times already).

Fixing that todo seems a bit out of scope here.

[...]

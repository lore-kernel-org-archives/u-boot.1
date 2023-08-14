Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED8EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276AD86963;
	Mon, 14 Aug 2023 23:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lp8oLJOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA258696B; Mon, 14 Aug 2023 23:23:27 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id CB93880842
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [192.168.1.68] (d172-218-241-181.bchsia.telus.net
 [172.218.241.181])
 by linux.microsoft.com (Postfix) with ESMTPSA id 790892109420;
 Mon, 14 Aug 2023 14:23:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 790892109420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1692048203;
 bh=uMRuuQn1Uvg/rRLSKqiKmxMkdQZlXJOb1ti3fxGXPTA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lp8oLJOpzxjp/vzLJ2jJ24dStUQAqNUiZlsIrQMHzwHJ/nsb6g4ns1bFmqCKFXR+S
 ImG9F9PZO+RlUgA6NAVy//hUwT+3ul5EPD0stEwudS6o4rdopyZQwDgC4NA5pRbuUo
 J0FRKUl0AWS2MEjB/aczxXT8rvz8rbO82b6m6xxA=
Subject: Re: [PATCH 2/5] drivers: security: Add TPM2 implementation of
 security devices
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, stcarlso@linux.microsoft.com,
 abdellatif.elkhlifi@arm.com
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-3-seanedmond@linux.microsoft.com>
 <CAC_iWjL7sx6F4d2VtvjksJ04z00bxjGGoefCdAUU+_0t598h8g@mail.gmail.com>
From: Sean Edmond <seanedmond@linux.microsoft.com>
Message-ID: <af88b677-77ff-0245-a76a-901b9d9ac998@linux.microsoft.com>
Date: Mon, 14 Aug 2023 14:23:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWjL7sx6F4d2VtvjksJ04z00bxjGGoefCdAUU+_0t598h8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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


On 2023-08-14 1:39 a.m., Ilias Apalodimas wrote:
> Hi Sean
>
> On Sat, 12 Aug 2023 at 03:28, <seanedmond@linux.microsoft.com> wrote:
>> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>>
>> This implementation of the security uclass driver allows existing TPM2
>> devices declared in the device tree to be referenced for storing the OS
>> anti-rollback counter, using the TPM2 non-volatile storage API.
>>
>> Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
>> ---
>>   MAINTAINERS                     |   1 +
>>   drivers/security/Makefile       |   1 +
>>   drivers/security/security-tpm.c | 173 ++++++++++++++++++++++++++++++++
>>   include/tpm-v2.h                |   1 +
>>   4 files changed, 176 insertions(+)
>>   create mode 100644 drivers/security/security-tpm.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
> [...]
>
>> +
>> +struct security_state {
>> +       u32 index_arbvn;
>> +       struct udevice *tpm_dev;
>> +};
>> +
>> +static int tpm_security_init(struct udevice *tpm_dev)
>> +{
>> +       int res;
>> +
>> +       /* Initialize TPM but allow reuse of existing session */
>> +       res = tpm_open(tpm_dev);
>> +       if (res == -EBUSY) {
>> +               log(UCLASS_SECURITY, LOGL_DEBUG,
>> +                   "Existing TPM session found, reusing\n");
>> +       } else {
>> +               if (res) {
>> +                       log(UCLASS_SECURITY, LOGL_ERR,
>> +                           "TPM initialization failed (ret=%d)\n", res);
>> +                       return res;
>> +               }
>> +
>> +               res = tpm2_startup(tpm_dev, TPM2_SU_CLEAR);
>> +               if (res) {
>> +                       log(UCLASS_SECURITY, LOGL_ERR,
>> +                           "TPM startup failed (ret=%d)\n", res);
>> +                       return res;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
> There's nothing security related in that wrapper.  It looks like a
> typical tpm startup sequence.  Any reason you can't use
> tpm_auto_start()?

Good suggestion, I'll make this change.

>
>> +
>> +static int tpm_security_arbvn_get(struct udevice *dev, u64 *arbvn)
>> +{
>> +       struct security_state *priv = dev_get_priv(dev);
>> +       int ret;
>> +
>> +       if (!arbvn)
>> +               return -EINVAL;
>> +
>> +       ret = tpm2_nv_read_value(priv->tpm_dev, priv->index_arbvn, arbvn,
>> +                                sizeof(u64));
>> +       if (ret == TPM2_RC_NV_UNINITIALIZED) {
>> +               /* Expected if no OS image has been loaded before */
>> +               log(UCLASS_SECURITY, LOGL_INFO,
>> +                   "No previous OS image, defaulting ARBVN to 0\n");
>> +               *arbvn = 0ULL;
> Why aren't we returning an error here?  Looks like the code following
> this is trying to reason with the validity of arbnv
On the first boot (before ARBVN has been set in NV memory), it's 
expected that the NV index hasn't been initialized/written yet.  In this 
case, TPM2_RC_NV_UNINITIALIZED is expected.  A value of 0 is returned to 
ensure that the anti-rollback check always passes (which it should since 
there's nothing to check on the first boot).
>
>> +       } else if (ret) {
>> +               log(UCLASS_SECURITY, LOGL_ERR,
>> +                   "Unable to read ARBVN from TPM (ret=%d)\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int tpm_security_arbvn_set(struct udevice *dev, u64 arbvn)
>> +{
>> +       struct security_state *priv = dev_get_priv(dev);
>> +       struct udevice *tpm_dev = priv->tpm_dev;
>> +       u64 old_arbvn;
>> +       int ret;
>> +
>> +       ret = tpm_security_arbvn_get(dev, &old_arbvn);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (arbvn < old_arbvn)
>> +               return -EPERM;
>> +
> What happens if they are equal ?
>
If they are equal, then we are booting the same OS that was previously 
booted (we are not moving the OS version forward or back).

Note the actual "anti-rollback" check is in fit_image_verify_arbvn().  
If it make things more clear, we could remove the value checks here 
completely and just write the value.

>> +       if (arbvn > old_arbvn) {
> You just check for this and exited
>
>> +               ret = tpm2_nv_write_value(tpm_dev, priv->index_arbvn, &arbvn,
>> +                                         sizeof(u64));
>> +               if (ret) {
>> +                       log(UCLASS_SECURITY, LOGL_ERR,
>> +                           "Unable to write ARBVN to TPM (ret=%d)\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dm_security_ops tpm_security_ops = {
>> +       .arbvn_get              = tpm_security_arbvn_get,
>> +       .arbvn_set              = tpm_security_arbvn_set,
>> +};
>> +
>> +static int tpm_security_probe(struct udevice *dev)
>> +{
>> +       struct security_state *priv = dev_get_priv(dev);
>> +       struct udevice *tpm_dev = priv->tpm_dev;
>> +       u32 index = priv->index_arbvn;
>> +       int ret;
>> +
>> +       if (!tpm_dev) {
>> +               log(UCLASS_SECURITY, LOGL_ERR,
>> +                   "TPM device not defined in DTS\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = tpm_security_init(tpm_dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = tpm2_nv_define_space(tpm_dev, index, sizeof(u64), TPMA_NV_PPREAD |
>> +                                  TPMA_NV_PPWRITE | TPMA_NV_PLATFORMCREATE,
>> +                                  NULL, 0);
> How secure is that ? Is it protected by a locality? We dont seem to be
> using an auth value when creating the index
On our platform, we're using a different security device driver to 
provide our secure storage (we aren't using this TPM backed driver).  
I'm not an expert on authorization for NV indexes, but I'd welcome 
feedback on how we could make this driver more secure (and publicly 
available) for others.
>
>> +       /* NV_DEFINED is an expected error if ARBVN already initialized */
>> +       if (ret == TPM2_RC_NV_DEFINED)
>> +               log(UCLASS_SECURITY, LOGL_DEBUG,
>> +                   "ARBVN index %u already defined\n", index);
> I'd prefer returning 0 here. The rewrite the code below as
>   if (ret)
>     log().....
>
> return ret;
>
>> +       else if (ret) {
>> +               log(UCLASS_SECURITY, LOGL_ERR,
>> +                   "Unable to create ARBVN NV index (ret=%d)\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int tpm_security_remove(struct udevice *dev)
>> +{
>> +       struct security_state *priv = dev_get_priv(dev);
>> +
>> +       return tpm_close(priv->tpm_dev);
>> +}
>> +
>> +static int tpm_security_ofdata_to_platdata(struct udevice *dev)
>> +{
>> +       const u32 phandle = (u32)dev_read_u32_default(dev, "tpm", 0);
>> +       struct security_state *priv = dev_get_priv(dev);
>> +       struct udevice *tpm_dev;
>> +       int ret;
>> +
>> +       ret = uclass_get_device_by_phandle_id(UCLASS_TPM, phandle, &tpm_dev);
>> +       if (ret) {
>> +               log(UCLASS_SECURITY, LOGL_ERR, "TPM node in DTS is invalid\n");
>> +               return ret;
>> +       }
>> +
>> +       priv->index_arbvn = (u32)dev_read_u32_default(dev, "arbvn-nv-index", 0);
>> +       priv->tpm_dev = tpm_dev;
>> +       return 0;
>> +}
>> +
>> +static const struct udevice_id tpm_security_ids[] = {
>> +       { .compatible = "tpm,security" },
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(security_tpm) = {
>> +       .name   = "security_tpm",
>> +       .id     = UCLASS_SECURITY,
>> +       .priv_auto = sizeof(struct security_state),
>> +       .of_match = tpm_security_ids,
>> +       .of_to_plat = tpm_security_ofdata_to_platdata,
>> +       .probe  = tpm_security_probe,
>> +       .remove = tpm_security_remove,
>> +       .ops    = &tpm_security_ops,
>> +};
>> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
>> index 2b6980e441..49bf0f0ba4 100644
>> --- a/include/tpm-v2.h
>> +++ b/include/tpm-v2.h
>> @@ -321,6 +321,7 @@ enum tpm2_return_codes {
>>          TPM2_RC_COMMAND_CODE    = TPM2_RC_VER1 + 0x0043,
>>          TPM2_RC_AUTHSIZE        = TPM2_RC_VER1 + 0x0044,
>>          TPM2_RC_AUTH_CONTEXT    = TPM2_RC_VER1 + 0x0045,
>> +       TPM2_RC_NV_UNINITIALIZED        = TPM2_RC_VER1 + 0x04a,
>>          TPM2_RC_NV_DEFINED      = TPM2_RC_VER1 + 0x004c,
>>          TPM2_RC_NEEDS_TEST      = TPM2_RC_VER1 + 0x0053,
>>          TPM2_RC_WARN            = 0x0900,
>> --
>> 2.40.0
>>
> Thanks
> /Ilias
>
>
